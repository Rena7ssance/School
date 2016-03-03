{-# OPTIONS_GHC -w #-}
module StatefulParse where
import Prelude hiding (LT, GT, EQ, idt)
import Data.Char
import Stateful
import Lexer
import Operators
import Control.Applicative(Applicative(..))

-- parser produced by Happy Version 1.19.4

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11
	| HappyAbsSyn12 t12

action_0 (13) = happyShift action_10
action_0 (14) = happyShift action_11
action_0 (16) = happyShift action_12
action_0 (17) = happyShift action_13
action_0 (18) = happyShift action_14
action_0 (19) = happyShift action_15
action_0 (20) = happyShift action_16
action_0 (21) = happyShift action_17
action_0 (23) = happyShift action_18
action_0 (24) = happyShift action_19
action_0 (27) = happyShift action_20
action_0 (36) = happyShift action_21
action_0 (37) = happyShift action_22
action_0 (39) = happyShift action_23
action_0 (4) = happyGoto action_24
action_0 (5) = happyGoto action_25
action_0 (6) = happyGoto action_3
action_0 (7) = happyGoto action_4
action_0 (8) = happyGoto action_5
action_0 (9) = happyGoto action_6
action_0 (10) = happyGoto action_7
action_0 (11) = happyGoto action_8
action_0 (12) = happyGoto action_9
action_0 _ = happyFail

action_1 (13) = happyShift action_10
action_1 (14) = happyShift action_11
action_1 (16) = happyShift action_12
action_1 (17) = happyShift action_13
action_1 (18) = happyShift action_14
action_1 (19) = happyShift action_15
action_1 (20) = happyShift action_16
action_1 (21) = happyShift action_17
action_1 (23) = happyShift action_18
action_1 (24) = happyShift action_19
action_1 (27) = happyShift action_20
action_1 (36) = happyShift action_21
action_1 (37) = happyShift action_22
action_1 (39) = happyShift action_23
action_1 (5) = happyGoto action_2
action_1 (6) = happyGoto action_3
action_1 (7) = happyGoto action_4
action_1 (8) = happyGoto action_5
action_1 (9) = happyGoto action_6
action_1 (10) = happyGoto action_7
action_1 (11) = happyGoto action_8
action_1 (12) = happyGoto action_9
action_1 _ = happyFail

action_2 (22) = happyShift action_26
action_2 _ = happyFail

action_3 _ = happyReduce_6

action_4 (25) = happyShift action_47
action_4 (38) = happyShift action_48
action_4 _ = happyReduce_9

action_5 (35) = happyShift action_46
action_5 _ = happyReduce_11

action_6 (30) = happyShift action_41
action_6 (31) = happyShift action_42
action_6 (32) = happyShift action_43
action_6 (33) = happyShift action_44
action_6 (34) = happyShift action_45
action_6 _ = happyReduce_13

action_7 (26) = happyShift action_39
action_7 (27) = happyShift action_40
action_7 _ = happyReduce_19

action_8 (28) = happyShift action_37
action_8 (29) = happyShift action_38
action_8 _ = happyReduce_22

action_9 (39) = happyShift action_36
action_9 _ = happyReduce_25

action_10 (39) = happyShift action_35
action_10 _ = happyFail

action_11 (39) = happyShift action_34
action_11 _ = happyFail

action_12 _ = happyReduce_28

action_13 _ = happyReduce_29

action_14 (23) = happyShift action_33
action_14 _ = happyFail

action_15 (16) = happyShift action_12
action_15 (17) = happyShift action_13
action_15 (19) = happyShift action_15
action_15 (20) = happyShift action_16
action_15 (23) = happyShift action_18
action_15 (24) = happyShift action_19
action_15 (27) = happyShift action_20
action_15 (36) = happyShift action_21
action_15 (37) = happyShift action_22
action_15 (39) = happyShift action_23
action_15 (12) = happyGoto action_32
action_15 _ = happyFail

action_16 _ = happyReduce_30

action_17 (13) = happyShift action_10
action_17 (14) = happyShift action_11
action_17 (16) = happyShift action_12
action_17 (17) = happyShift action_13
action_17 (18) = happyShift action_14
action_17 (19) = happyShift action_15
action_17 (20) = happyShift action_16
action_17 (21) = happyShift action_17
action_17 (23) = happyShift action_18
action_17 (24) = happyShift action_19
action_17 (27) = happyShift action_20
action_17 (36) = happyShift action_21
action_17 (37) = happyShift action_22
action_17 (39) = happyShift action_23
action_17 (5) = happyGoto action_31
action_17 (6) = happyGoto action_3
action_17 (7) = happyGoto action_4
action_17 (8) = happyGoto action_5
action_17 (9) = happyGoto action_6
action_17 (10) = happyGoto action_7
action_17 (11) = happyGoto action_8
action_17 (12) = happyGoto action_9
action_17 _ = happyFail

action_18 _ = happyReduce_35

action_19 _ = happyReduce_27

action_20 (16) = happyShift action_12
action_20 (17) = happyShift action_13
action_20 (19) = happyShift action_15
action_20 (20) = happyShift action_16
action_20 (23) = happyShift action_18
action_20 (24) = happyShift action_19
action_20 (27) = happyShift action_20
action_20 (36) = happyShift action_21
action_20 (37) = happyShift action_22
action_20 (39) = happyShift action_23
action_20 (12) = happyGoto action_30
action_20 _ = happyFail

action_21 (16) = happyShift action_12
action_21 (17) = happyShift action_13
action_21 (19) = happyShift action_15
action_21 (20) = happyShift action_16
action_21 (23) = happyShift action_18
action_21 (24) = happyShift action_19
action_21 (27) = happyShift action_20
action_21 (36) = happyShift action_21
action_21 (37) = happyShift action_22
action_21 (39) = happyShift action_23
action_21 (12) = happyGoto action_29
action_21 _ = happyFail

action_22 (16) = happyShift action_12
action_22 (17) = happyShift action_13
action_22 (19) = happyShift action_15
action_22 (20) = happyShift action_16
action_22 (23) = happyShift action_18
action_22 (24) = happyShift action_19
action_22 (27) = happyShift action_20
action_22 (36) = happyShift action_21
action_22 (37) = happyShift action_22
action_22 (39) = happyShift action_23
action_22 (12) = happyGoto action_28
action_22 _ = happyFail

action_23 (13) = happyShift action_10
action_23 (14) = happyShift action_11
action_23 (16) = happyShift action_12
action_23 (17) = happyShift action_13
action_23 (18) = happyShift action_14
action_23 (19) = happyShift action_15
action_23 (20) = happyShift action_16
action_23 (21) = happyShift action_17
action_23 (23) = happyShift action_18
action_23 (24) = happyShift action_19
action_23 (27) = happyShift action_20
action_23 (36) = happyShift action_21
action_23 (37) = happyShift action_22
action_23 (39) = happyShift action_23
action_23 (4) = happyGoto action_27
action_23 (5) = happyGoto action_25
action_23 (6) = happyGoto action_3
action_23 (7) = happyGoto action_4
action_23 (8) = happyGoto action_5
action_23 (9) = happyGoto action_6
action_23 (10) = happyGoto action_7
action_23 (11) = happyGoto action_8
action_23 (12) = happyGoto action_9
action_23 _ = happyFail

action_24 (43) = happyAccept
action_24 _ = happyFail

action_25 (22) = happyShift action_26
action_25 _ = happyReduce_2

action_26 (13) = happyShift action_10
action_26 (14) = happyShift action_11
action_26 (16) = happyShift action_12
action_26 (17) = happyShift action_13
action_26 (18) = happyShift action_14
action_26 (19) = happyShift action_15
action_26 (20) = happyShift action_16
action_26 (21) = happyShift action_17
action_26 (23) = happyShift action_18
action_26 (24) = happyShift action_19
action_26 (27) = happyShift action_20
action_26 (36) = happyShift action_21
action_26 (37) = happyShift action_22
action_26 (39) = happyShift action_23
action_26 (4) = happyGoto action_66
action_26 (5) = happyGoto action_25
action_26 (6) = happyGoto action_3
action_26 (7) = happyGoto action_4
action_26 (8) = happyGoto action_5
action_26 (9) = happyGoto action_6
action_26 (10) = happyGoto action_7
action_26 (11) = happyGoto action_8
action_26 (12) = happyGoto action_9
action_26 _ = happyFail

action_27 (40) = happyShift action_65
action_27 _ = happyFail

action_28 (39) = happyShift action_36
action_28 _ = happyReduce_33

action_29 (39) = happyShift action_36
action_29 _ = happyReduce_32

action_30 (39) = happyShift action_36
action_30 _ = happyReduce_31

action_31 _ = happyReduce_7

action_32 (39) = happyShift action_36
action_32 _ = happyReduce_34

action_33 (25) = happyShift action_64
action_33 _ = happyFail

action_34 (13) = happyShift action_10
action_34 (14) = happyShift action_11
action_34 (16) = happyShift action_12
action_34 (17) = happyShift action_13
action_34 (18) = happyShift action_14
action_34 (19) = happyShift action_15
action_34 (20) = happyShift action_16
action_34 (21) = happyShift action_17
action_34 (23) = happyShift action_18
action_34 (24) = happyShift action_19
action_34 (27) = happyShift action_20
action_34 (36) = happyShift action_21
action_34 (37) = happyShift action_22
action_34 (39) = happyShift action_23
action_34 (4) = happyGoto action_63
action_34 (5) = happyGoto action_25
action_34 (6) = happyGoto action_3
action_34 (7) = happyGoto action_4
action_34 (8) = happyGoto action_5
action_34 (9) = happyGoto action_6
action_34 (10) = happyGoto action_7
action_34 (11) = happyGoto action_8
action_34 (12) = happyGoto action_9
action_34 _ = happyFail

action_35 (23) = happyShift action_62
action_35 _ = happyFail

action_36 (13) = happyShift action_10
action_36 (14) = happyShift action_11
action_36 (16) = happyShift action_12
action_36 (17) = happyShift action_13
action_36 (18) = happyShift action_14
action_36 (19) = happyShift action_15
action_36 (20) = happyShift action_16
action_36 (21) = happyShift action_17
action_36 (23) = happyShift action_18
action_36 (24) = happyShift action_19
action_36 (27) = happyShift action_20
action_36 (36) = happyShift action_21
action_36 (37) = happyShift action_22
action_36 (39) = happyShift action_23
action_36 (4) = happyGoto action_61
action_36 (5) = happyGoto action_25
action_36 (6) = happyGoto action_3
action_36 (7) = happyGoto action_4
action_36 (8) = happyGoto action_5
action_36 (9) = happyGoto action_6
action_36 (10) = happyGoto action_7
action_36 (11) = happyGoto action_8
action_36 (12) = happyGoto action_9
action_36 _ = happyFail

action_37 (16) = happyShift action_12
action_37 (17) = happyShift action_13
action_37 (19) = happyShift action_15
action_37 (20) = happyShift action_16
action_37 (23) = happyShift action_18
action_37 (24) = happyShift action_19
action_37 (27) = happyShift action_20
action_37 (36) = happyShift action_21
action_37 (37) = happyShift action_22
action_37 (39) = happyShift action_23
action_37 (12) = happyGoto action_60
action_37 _ = happyFail

action_38 (16) = happyShift action_12
action_38 (17) = happyShift action_13
action_38 (19) = happyShift action_15
action_38 (20) = happyShift action_16
action_38 (23) = happyShift action_18
action_38 (24) = happyShift action_19
action_38 (27) = happyShift action_20
action_38 (36) = happyShift action_21
action_38 (37) = happyShift action_22
action_38 (39) = happyShift action_23
action_38 (12) = happyGoto action_59
action_38 _ = happyFail

action_39 (16) = happyShift action_12
action_39 (17) = happyShift action_13
action_39 (19) = happyShift action_15
action_39 (20) = happyShift action_16
action_39 (23) = happyShift action_18
action_39 (24) = happyShift action_19
action_39 (27) = happyShift action_20
action_39 (36) = happyShift action_21
action_39 (37) = happyShift action_22
action_39 (39) = happyShift action_23
action_39 (11) = happyGoto action_58
action_39 (12) = happyGoto action_9
action_39 _ = happyFail

action_40 (16) = happyShift action_12
action_40 (17) = happyShift action_13
action_40 (19) = happyShift action_15
action_40 (20) = happyShift action_16
action_40 (23) = happyShift action_18
action_40 (24) = happyShift action_19
action_40 (27) = happyShift action_20
action_40 (36) = happyShift action_21
action_40 (37) = happyShift action_22
action_40 (39) = happyShift action_23
action_40 (11) = happyGoto action_57
action_40 (12) = happyGoto action_9
action_40 _ = happyFail

action_41 (16) = happyShift action_12
action_41 (17) = happyShift action_13
action_41 (19) = happyShift action_15
action_41 (20) = happyShift action_16
action_41 (23) = happyShift action_18
action_41 (24) = happyShift action_19
action_41 (27) = happyShift action_20
action_41 (36) = happyShift action_21
action_41 (37) = happyShift action_22
action_41 (39) = happyShift action_23
action_41 (10) = happyGoto action_56
action_41 (11) = happyGoto action_8
action_41 (12) = happyGoto action_9
action_41 _ = happyFail

action_42 (16) = happyShift action_12
action_42 (17) = happyShift action_13
action_42 (19) = happyShift action_15
action_42 (20) = happyShift action_16
action_42 (23) = happyShift action_18
action_42 (24) = happyShift action_19
action_42 (27) = happyShift action_20
action_42 (36) = happyShift action_21
action_42 (37) = happyShift action_22
action_42 (39) = happyShift action_23
action_42 (10) = happyGoto action_55
action_42 (11) = happyGoto action_8
action_42 (12) = happyGoto action_9
action_42 _ = happyFail

action_43 (16) = happyShift action_12
action_43 (17) = happyShift action_13
action_43 (19) = happyShift action_15
action_43 (20) = happyShift action_16
action_43 (23) = happyShift action_18
action_43 (24) = happyShift action_19
action_43 (27) = happyShift action_20
action_43 (36) = happyShift action_21
action_43 (37) = happyShift action_22
action_43 (39) = happyShift action_23
action_43 (10) = happyGoto action_54
action_43 (11) = happyGoto action_8
action_43 (12) = happyGoto action_9
action_43 _ = happyFail

action_44 (16) = happyShift action_12
action_44 (17) = happyShift action_13
action_44 (19) = happyShift action_15
action_44 (20) = happyShift action_16
action_44 (23) = happyShift action_18
action_44 (24) = happyShift action_19
action_44 (27) = happyShift action_20
action_44 (36) = happyShift action_21
action_44 (37) = happyShift action_22
action_44 (39) = happyShift action_23
action_44 (10) = happyGoto action_53
action_44 (11) = happyGoto action_8
action_44 (12) = happyGoto action_9
action_44 _ = happyFail

action_45 (16) = happyShift action_12
action_45 (17) = happyShift action_13
action_45 (19) = happyShift action_15
action_45 (20) = happyShift action_16
action_45 (23) = happyShift action_18
action_45 (24) = happyShift action_19
action_45 (27) = happyShift action_20
action_45 (36) = happyShift action_21
action_45 (37) = happyShift action_22
action_45 (39) = happyShift action_23
action_45 (10) = happyGoto action_52
action_45 (11) = happyGoto action_8
action_45 (12) = happyGoto action_9
action_45 _ = happyFail

action_46 (16) = happyShift action_12
action_46 (17) = happyShift action_13
action_46 (19) = happyShift action_15
action_46 (20) = happyShift action_16
action_46 (23) = happyShift action_18
action_46 (24) = happyShift action_19
action_46 (27) = happyShift action_20
action_46 (36) = happyShift action_21
action_46 (37) = happyShift action_22
action_46 (39) = happyShift action_23
action_46 (9) = happyGoto action_51
action_46 (10) = happyGoto action_7
action_46 (11) = happyGoto action_8
action_46 (12) = happyGoto action_9
action_46 _ = happyFail

action_47 (16) = happyShift action_12
action_47 (17) = happyShift action_13
action_47 (19) = happyShift action_15
action_47 (20) = happyShift action_16
action_47 (23) = happyShift action_18
action_47 (24) = happyShift action_19
action_47 (27) = happyShift action_20
action_47 (36) = happyShift action_21
action_47 (37) = happyShift action_22
action_47 (39) = happyShift action_23
action_47 (6) = happyGoto action_50
action_47 (7) = happyGoto action_4
action_47 (8) = happyGoto action_5
action_47 (9) = happyGoto action_6
action_47 (10) = happyGoto action_7
action_47 (11) = happyGoto action_8
action_47 (12) = happyGoto action_9
action_47 _ = happyFail

action_48 (16) = happyShift action_12
action_48 (17) = happyShift action_13
action_48 (19) = happyShift action_15
action_48 (20) = happyShift action_16
action_48 (23) = happyShift action_18
action_48 (24) = happyShift action_19
action_48 (27) = happyShift action_20
action_48 (36) = happyShift action_21
action_48 (37) = happyShift action_22
action_48 (39) = happyShift action_23
action_48 (8) = happyGoto action_49
action_48 (9) = happyGoto action_6
action_48 (10) = happyGoto action_7
action_48 (11) = happyGoto action_8
action_48 (12) = happyGoto action_9
action_48 _ = happyFail

action_49 (35) = happyShift action_46
action_49 _ = happyReduce_10

action_50 _ = happyReduce_8

action_51 (30) = happyShift action_41
action_51 (31) = happyShift action_42
action_51 (32) = happyShift action_43
action_51 (33) = happyShift action_44
action_51 (34) = happyShift action_45
action_51 _ = happyReduce_12

action_52 (26) = happyShift action_39
action_52 (27) = happyShift action_40
action_52 _ = happyReduce_14

action_53 (26) = happyShift action_39
action_53 (27) = happyShift action_40
action_53 _ = happyReduce_18

action_54 (26) = happyShift action_39
action_54 (27) = happyShift action_40
action_54 _ = happyReduce_17

action_55 (26) = happyShift action_39
action_55 (27) = happyShift action_40
action_55 _ = happyReduce_16

action_56 (26) = happyShift action_39
action_56 (27) = happyShift action_40
action_56 _ = happyReduce_15

action_57 (28) = happyShift action_37
action_57 (29) = happyShift action_38
action_57 _ = happyReduce_21

action_58 (28) = happyShift action_37
action_58 (29) = happyShift action_38
action_58 _ = happyReduce_20

action_59 (39) = happyShift action_36
action_59 _ = happyReduce_24

action_60 (39) = happyShift action_36
action_60 _ = happyReduce_23

action_61 (40) = happyShift action_70
action_61 _ = happyFail

action_62 (40) = happyShift action_69
action_62 _ = happyFail

action_63 (40) = happyShift action_68
action_63 _ = happyFail

action_64 (13) = happyShift action_10
action_64 (14) = happyShift action_11
action_64 (16) = happyShift action_12
action_64 (17) = happyShift action_13
action_64 (18) = happyShift action_14
action_64 (19) = happyShift action_15
action_64 (20) = happyShift action_16
action_64 (21) = happyShift action_17
action_64 (23) = happyShift action_18
action_64 (24) = happyShift action_19
action_64 (27) = happyShift action_20
action_64 (36) = happyShift action_21
action_64 (37) = happyShift action_22
action_64 (39) = happyShift action_23
action_64 (5) = happyGoto action_67
action_64 (6) = happyGoto action_3
action_64 (7) = happyGoto action_4
action_64 (8) = happyGoto action_5
action_64 (9) = happyGoto action_6
action_64 (10) = happyGoto action_7
action_64 (11) = happyGoto action_8
action_64 (12) = happyGoto action_9
action_64 _ = happyFail

action_65 _ = happyReduce_36

action_66 _ = happyReduce_1

action_67 (22) = happyShift action_73
action_67 _ = happyFail

action_68 (41) = happyShift action_72
action_68 _ = happyFail

action_69 (41) = happyShift action_71
action_69 _ = happyFail

action_70 _ = happyReduce_26

action_71 (13) = happyShift action_10
action_71 (14) = happyShift action_11
action_71 (16) = happyShift action_12
action_71 (17) = happyShift action_13
action_71 (18) = happyShift action_14
action_71 (19) = happyShift action_15
action_71 (20) = happyShift action_16
action_71 (21) = happyShift action_17
action_71 (23) = happyShift action_18
action_71 (24) = happyShift action_19
action_71 (27) = happyShift action_20
action_71 (36) = happyShift action_21
action_71 (37) = happyShift action_22
action_71 (39) = happyShift action_23
action_71 (4) = happyGoto action_76
action_71 (5) = happyGoto action_25
action_71 (6) = happyGoto action_3
action_71 (7) = happyGoto action_4
action_71 (8) = happyGoto action_5
action_71 (9) = happyGoto action_6
action_71 (10) = happyGoto action_7
action_71 (11) = happyGoto action_8
action_71 (12) = happyGoto action_9
action_71 _ = happyFail

action_72 (13) = happyShift action_10
action_72 (14) = happyShift action_11
action_72 (16) = happyShift action_12
action_72 (17) = happyShift action_13
action_72 (18) = happyShift action_14
action_72 (19) = happyShift action_15
action_72 (20) = happyShift action_16
action_72 (21) = happyShift action_17
action_72 (23) = happyShift action_18
action_72 (24) = happyShift action_19
action_72 (27) = happyShift action_20
action_72 (36) = happyShift action_21
action_72 (37) = happyShift action_22
action_72 (39) = happyShift action_23
action_72 (4) = happyGoto action_75
action_72 (5) = happyGoto action_25
action_72 (6) = happyGoto action_3
action_72 (7) = happyGoto action_4
action_72 (8) = happyGoto action_5
action_72 (9) = happyGoto action_6
action_72 (10) = happyGoto action_7
action_72 (11) = happyGoto action_8
action_72 (12) = happyGoto action_9
action_72 _ = happyFail

action_73 (13) = happyShift action_10
action_73 (14) = happyShift action_11
action_73 (16) = happyShift action_12
action_73 (17) = happyShift action_13
action_73 (18) = happyShift action_14
action_73 (19) = happyShift action_15
action_73 (20) = happyShift action_16
action_73 (21) = happyShift action_17
action_73 (23) = happyShift action_18
action_73 (24) = happyShift action_19
action_73 (27) = happyShift action_20
action_73 (36) = happyShift action_21
action_73 (37) = happyShift action_22
action_73 (39) = happyShift action_23
action_73 (4) = happyGoto action_74
action_73 (5) = happyGoto action_25
action_73 (6) = happyGoto action_3
action_73 (7) = happyGoto action_4
action_73 (8) = happyGoto action_5
action_73 (9) = happyGoto action_6
action_73 (10) = happyGoto action_7
action_73 (11) = happyGoto action_8
action_73 (12) = happyGoto action_9
action_73 _ = happyFail

action_74 _ = happyReduce_4

action_75 (42) = happyShift action_78
action_75 _ = happyFail

action_76 (42) = happyShift action_77
action_76 _ = happyFail

action_77 _ = happyReduce_3

action_78 (15) = happyShift action_79
action_78 _ = happyFail

action_79 (41) = happyShift action_80
action_79 _ = happyFail

action_80 (13) = happyShift action_10
action_80 (14) = happyShift action_11
action_80 (16) = happyShift action_12
action_80 (17) = happyShift action_13
action_80 (18) = happyShift action_14
action_80 (19) = happyShift action_15
action_80 (20) = happyShift action_16
action_80 (21) = happyShift action_17
action_80 (23) = happyShift action_18
action_80 (24) = happyShift action_19
action_80 (27) = happyShift action_20
action_80 (36) = happyShift action_21
action_80 (37) = happyShift action_22
action_80 (39) = happyShift action_23
action_80 (4) = happyGoto action_81
action_80 (5) = happyGoto action_25
action_80 (6) = happyGoto action_3
action_80 (7) = happyGoto action_4
action_80 (8) = happyGoto action_5
action_80 (9) = happyGoto action_6
action_80 (10) = happyGoto action_7
action_80 (11) = happyGoto action_8
action_80 (12) = happyGoto action_9
action_80 _ = happyFail

action_81 (42) = happyShift action_82
action_81 _ = happyFail

action_82 _ = happyReduce_5

happyReduce_1 = happySpecReduce_3  4 happyReduction_1
happyReduction_1 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (Seq happy_var_1 happy_var_3
	)
happyReduction_1 _ _ _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  4 happyReduction_2
happyReduction_2 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happyReduce 7 5 happyReduction_3
happyReduction_3 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenIdent happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Function happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_4 = happyReduce 6 5 happyReduction_4
happyReduction_4 ((HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenIdent happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Declare happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_5 = happyReduce 11 5 happyReduction_5
happyReduction_5 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_10) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (If happy_var_3 happy_var_6 happy_var_10
	) `HappyStk` happyRest

happyReduce_6 = happySpecReduce_1  5 happyReduction_6
happyReduction_6 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_2  5 happyReduction_7
happyReduction_7 (HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (Return happy_var_2
	)
happyReduction_7 _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_3  6 happyReduction_8
happyReduction_8 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (Assign happy_var_1 happy_var_3
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_1  6 happyReduction_9
happyReduction_9 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_3  7 happyReduction_10
happyReduction_10 (HappyAbsSyn8  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Binary Or happy_var_1 happy_var_3
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_1  7 happyReduction_11
happyReduction_11 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  8 happyReduction_12
happyReduction_12 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn8
		 (Binary And happy_var_1 happy_var_3
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_1  8 happyReduction_13
happyReduction_13 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_1
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  9 happyReduction_14
happyReduction_14 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Binary EQ happy_var_1 happy_var_3
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  9 happyReduction_15
happyReduction_15 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Binary LT happy_var_1 happy_var_3
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_3  9 happyReduction_16
happyReduction_16 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Binary GT happy_var_1 happy_var_3
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_3  9 happyReduction_17
happyReduction_17 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Binary LE happy_var_1 happy_var_3
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_3  9 happyReduction_18
happyReduction_18 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Binary GE happy_var_1 happy_var_3
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_1  9 happyReduction_19
happyReduction_19 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_3  10 happyReduction_20
happyReduction_20 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (Binary Add happy_var_1 happy_var_3
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  10 happyReduction_21
happyReduction_21 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (Binary Sub happy_var_1 happy_var_3
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1  10 happyReduction_22
happyReduction_22 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  11 happyReduction_23
happyReduction_23 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (Binary Mul happy_var_1 happy_var_3
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  11 happyReduction_24
happyReduction_24 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (Binary Div happy_var_1 happy_var_3
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  11 happyReduction_25
happyReduction_25 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happyReduce 4 12 happyReduction_26
happyReduction_26 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (Call happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_27 = happySpecReduce_1  12 happyReduction_27
happyReduction_27 (HappyTerminal (Digits happy_var_1))
	 =  HappyAbsSyn12
		 (Literal (IntV happy_var_1)
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  12 happyReduction_28
happyReduction_28 _
	 =  HappyAbsSyn12
		 (Literal (BoolV True)
	)

happyReduce_29 = happySpecReduce_1  12 happyReduction_29
happyReduction_29 _
	 =  HappyAbsSyn12
		 (Literal (BoolV False)
	)

happyReduce_30 = happySpecReduce_1  12 happyReduction_30
happyReduction_30 _
	 =  HappyAbsSyn12
		 (Literal (Undefined)
	)

happyReduce_31 = happySpecReduce_2  12 happyReduction_31
happyReduction_31 (HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (Unary Neg happy_var_2
	)
happyReduction_31 _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_2  12 happyReduction_32
happyReduction_32 (HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (Unary Not happy_var_2
	)
happyReduction_32 _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_2  12 happyReduction_33
happyReduction_33 (HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (Access happy_var_2
	)
happyReduction_33 _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_2  12 happyReduction_34
happyReduction_34 (HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (Mutable happy_var_2
	)
happyReduction_34 _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_1  12 happyReduction_35
happyReduction_35 (HappyTerminal (TokenIdent happy_var_1))
	 =  HappyAbsSyn12
		 (Variable happy_var_1
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_3  12 happyReduction_36
happyReduction_36 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (happy_var_2
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 43 43 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenKeyword "function" -> cont 13;
	TokenKeyword "if" -> cont 14;
	TokenKeyword "else" -> cont 15;
	TokenKeyword "true" -> cont 16;
	TokenKeyword "false" -> cont 17;
	TokenKeyword "var" -> cont 18;
	TokenKeyword "mutable" -> cont 19;
	TokenKeyword "undefined" -> cont 20;
	TokenKeyword "return" -> cont 21;
	Symbol ";" -> cont 22;
	TokenIdent happy_dollar_dollar -> cont 23;
	Digits happy_dollar_dollar -> cont 24;
	Symbol "=" -> cont 25;
	Symbol "+" -> cont 26;
	Symbol "-" -> cont 27;
	Symbol "*" -> cont 28;
	Symbol "/" -> cont 29;
	Symbol "<" -> cont 30;
	Symbol ">" -> cont 31;
	Symbol "<=" -> cont 32;
	Symbol ">=" -> cont 33;
	Symbol "==" -> cont 34;
	Symbol "&&" -> cont 35;
	Symbol "!" -> cont 36;
	Symbol "@" -> cont 37;
	Symbol "||" -> cont 38;
	Symbol "(" -> cont 39;
	Symbol ")" -> cont 40;
	Symbol "{" -> cont 41;
	Symbol "}" -> cont 42;
	_ -> happyError' (tk:tks)
	}

happyError_ 43 tk tks = happyError' tks
happyError_ _ tk tks = happyError' (tk:tks)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure    = return
    a <*> b = (fmap id a) <*> b
instance Monad HappyIdentity where
    return = HappyIdentity
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => [(Token)] -> HappyIdentity a
happyError' = HappyIdentity . happyError

parser tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


symbols = ["+", "-", "*", "/", "(", ")", "{", "}", ";", "==", "=", "<=", ">=", "<", ">", "||", "&&", "!", "@"]
keywords = ["function", "var", "if", "else", "true", "false", "mutable", "undefined", "return"]
parseExp str = parser (lexer symbols keywords str)

parseInput = do
  input <- getContents
  print (parseExp input)
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

























infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action



-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.

