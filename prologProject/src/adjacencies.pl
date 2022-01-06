:- include('utils.pl').

getNumFriends(Board,RN,CN,Turn,Friends) :-  getFriendUP(Board,RN,CN,Turn,UP),
                                            getFriendDOWN(Board,RN,CN,Turn,DOWN),
                                            getFriendLEFT(Board,RN,CN,Turn,LEFT),
                                            getFriendRIGHT(Board,RN,CN,Turn,RIGHT),
                                            Friends is UP + DOWN + LEFT + RIGHT.

getFriendUP(Board,RN,CN,Turn,Result) :- RN < 1, Result is 0.
getFriendUP(Board,RN,CN,Turn,Result) :- Row is RN - 1,
                                        get_result_equal(Board,Row,CN,Turn,Result).

getFriendDOWN(Board,RN,CN,Turn,Result) :-   RN > 4, Result is 0.
getFriendDOWN(Board,RN,CN,Turn,Result) :-   Row is RN + 1,
                                            get_result_equal(Board,Row,CN,Turn,Result).

getFriendLEFT(Board,RN,CN,Turn,Result) :-   CN < 1, Result is 0.
getFriendLEFT(Board,RN,CN,Turn,Result) :-   Col is CN - 1,
                                            get_result_equal(Board,RN,Col,Turn,Result).

getFriendRIGHT(Board,RN,CN,Turn,Result) :-  CN > 4, Result is 0.
getFriendRIGHT(Board,RN,CN,Turn,Result) :-  Col is CN + 1,
                                            get_result_equal(Board,RN,Col,Turn,Result).

get_result_equal(Board,Row,Col,Turn,Result) :-  getValue(Board,Row,Col,Res),
                                                (Res =:= Turn ->
                                                    Result is 1
                                                ; Result is 0
                                                ).

getNumEnemies(Board,RN,CN,Turn,Enemies) :-  getEnemiesUP(Board,RN,CN,Turn,UP),
                                            getEnemiesDOWN(Board,RN,CN,Turn,DOWN),
                                            getEnemiesLEFT(Board,RN,CN,Turn,LEFT),
                                            getEnemiesRIGHT(Board,RN,CN,Turn,RIGHT),
                                            Enemies is UP + DOWN + LEFT + RIGHT.

getEnemiesUP(Board,RN,CN,Turn,Result) :-    (RN > 0 -> Row is RN - 1, getValue(Board,Row,CN,ResUP),
                                                ((ResUP =\= Turn,ResUP =\= 0)  -> Result is 1 ; Result is 0)
                                            ; Result is 0
                                            ).

getEnemiesDOWN(Board,RN,CN,Turn,Result) :-  (RN < 5 -> Row is RN + 1, getValue(Board,Row,CN,ResDOWN),
                                                ((ResDOWN =\= Turn,ResDOWN =\= 0) -> Result is 1 ; Result is 0)
                                            ; Result is 0
                                            ).

getEnemiesLEFT(Board,RN,CN,Turn,Result) :-  (CN > 0 -> Col is CN - 1, getValue(Board,RN,Col,ResLEFT),
                                                ((ResLEFT =\= Turn,ResLEFT =\= 0) -> Result is 1 ; Result is 0)
                                            ; Result is 0
                                            ).

getEnemiesRIGHT(Board,RN,CN,Turn,Result) :- (CN < 5 -> Col is CN + 1, getValue(Board,RN,Col,ResRIGHT),
                                                ((ResRIGHT =\= Turn,ResRIGHT =\= 0) -> Result is 1 ; Result is 0)
                                            ; Result is 0
                                            ).

getValue(Board,RN,CN,Result) :- getV(RN,Board,Row),
                                getV(CN,Row,Result).