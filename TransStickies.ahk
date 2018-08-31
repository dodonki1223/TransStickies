;**********************************************************************
;* プログラム名  ：TransStickies（TransStickies.ahk）                 *
;* プログラム概要：ポインタ下にStickiesがある時は透明化を行う         *
;*                 ただし、左クリックを押されている時は透明化処理を行 *
;*                 わない                                             *
;* 依存関係      ：                                                   *
;**********************************************************************

;-----------------------------------------
; 定数
;-----------------------------------------
;透明化・非透明化対象EXE名
transWinExeName   := "stickies.exe"

;透明化・非透明化対象クラス名
stackWinClassName := "ZhornStickyStackShadow"
noteWinClassName  := "ZhornStickyNoteShadow"

;-----------------------------------------
; 透明化処理
;-----------------------------------------
TransProcess:

    Loop {

        ;ポインタ下のウィンドウのEXE名を取得
        MouseGetPos, oldmx, oldmy, mwin, mctrl
        WinGet, winExeName, ProcessName, ahk_id %mwin%

        ;左クリックのキー押し下げ状態を取得
        GetKeyState, lbutton, LButton, P

        ;「ポインタ下のウィンドウが透明化対象プロセス名の時」 かつ 「左クリックが押されていない時」
        if (winExeName == transWinExeName) And (lbutton = "U") {

            ;対象ウィンドウの透明化処理
            SetSameClassNameWinTrans("trans", stackWinClassName)
            SetSameClassNameWinTrans("trans", noteWinClassName)

        } else {

            ;対象ウィンドウの非透明化処理
            SetSameClassNameWinTrans("unTrans", stackWinClassName)
            SetSameClassNameWinTrans("unTrans", noteWinClassName)

        }

    }

Return

;-----------------------------------------
; ショートカット設定
;-----------------------------------------
KeySetting:

    ^Esc::pause

Return

;**********************************************************************
;* 処理概要：同じクラス名のウィンドウの透明化・非透明化処理           *
;* 処理説明：同じクラス名のウィンドウをすべて透明化・非透明を処理区分 *
;*           に応じて行います                                         *
;* 引数    ：processKbn 処理区分                                      *
;*             trans  ：透明化処理を行う                              *
;*             unTrans：非透明化処理を行う                            *
;*           className  透明化・非透明化対象クラス名                  *
;* 返り値  ：なし                                                     *
;**********************************************************************
SetSameClassNameWinTrans(processKbn, className)
{

    ;透明化を解除する対象ウィンドウの一覧を取得
    WinGet, targetWinId, list, ahk_class %className%

    ;透明化を解除するウィンドウの一覧分繰り返す
    Loop, %targetWinId% {

        ;対象ウィンドウを取得
        StringTrimRight, this_id, targetWinId%a_index%, 0
        if (processKbn == "trans") {
            ;ウィンドウの透明化処理
            WinSet, Transparent, 50 , ahk_id %this_id%
        } else if (processKbn == "unTrans")  {
            ;ウィンドウの非透明化処理
            WinSet, Transparent, OFF , ahk_id %this_id%
        }

    }

}
