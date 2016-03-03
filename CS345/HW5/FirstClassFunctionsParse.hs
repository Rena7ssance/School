{-# OPTIONS_GHC -w #-}
module FirstClassFunctionsParse where
import Prelude hiding (LT, GT, EQ)
import Data.Char
import FirstClassFunctions
import Lexer
import Operators
import Control.Applicative(Applicative(..))

-- parser produced by Happy Version 1.19.4

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10

action_0 (11) = happyShift action_2
action_0 (12) = happyShift action_10
action_0 (14) = happyShift action_11
action_0 (15) = happyShift action_12
action_0 (16) = happyShift action_13
action_0 (17) = happyShift action_14
action_0 (20) = happyShift action_15
action_0 (21) = happyShift action_16
action_0 (24) = happyShift action_17
action_0 (33) = happyShift action_18
action_0 (35) = happyShift action_19
action_0 (4) = happyGoto action_3
action_0 (5) = happyGoto action_4
action_0 (6) = happyGoto action_5
action_0 (7) = happyGoto action_6
action_0 (8) = happyGoto action_7
action_0 (9) = happyGoto action_8
action_0 (10) = happyGoto action_9
action_0 _ = happyFail

action_1 (11) = happyShift action_2
action_1 _ = happyFail

action_2 (35) = happyShift action_38
action_2 _ = happyFail

action_3 (39) = happyAccept
action_3 _ = happyFail

action_4 (34) = happyShift action_37
action_4 _ = happyReduce_5

action_5 (32) = happyShift action_36
action_5 _ = happyReduce_7

action_6 (27) = happyShift action_31
action_6 (28) = happyShift action_32
action_6 (29) = happyShift action_33
action_6 (30) = happyShift action_34
action_6 (31) = happyShift action_35
action_6 _ = happyReduce_9

action_7 (23) = happyShift action_29
action_7 (24) = happyShift action_30
action_7 _ = happyReduce_15

action_8 (25) = happyShift action_27
action_8 (26) = happyShift action_28
action_8 _ = happyReduce_18

action_9 (35) = happyShift action_26
action_9 _ = happyReduce_21

action_10 (35) = happyShift action_25
action_10 _ = happyFail

action_11 _ = happyReduce_24

action_12 _ = happyReduce_25

action_13 (20) = happyShift action_24
action_13 _ = happyFail

action_14 (37) = happyShift action_23
action_14 _ = happyFail

action_15 _ = happyReduce_28

action_16 _ = happyReduce_23

action_17 (14) = happyShift action_11
action_17 (15) = happyShift action_12
action_17 (20) = happyShift action_15
action_17 (21) = happyShift action_16
action_17 (24) = happyShift action_17
action_17 (33) = happyShift action_18
action_17 (35) = happyShift action_19
action_17 (10) = happyGoto action_22
action_17 _ = happyFail

action_18 (14) = happyShift action_11
action_18 (15) = happyShift action_12
action_18 (20) = happyShift action_15
action_18 (21) = happyShift action_16
action_18 (24) = happyShift action_17
action_18 (33) = happyShift action_18
action_18 (35) = happyShift action_19
action_18 (10) = happyGoto action_21
action_18 _ = happyFail

action_19 (11) = happyShift action_2
action_19 (12) = happyShift action_10
action_19 (14) = happyShift action_11
action_19 (15) = happyShift action_12
action_19 (16) = happyShift action_13
action_19 (17) = happyShift action_14
action_19 (20) = happyShift action_15
action_19 (21) = happyShift action_16
action_19 (24) = happyShift action_17
action_19 (33) = happyShift action_18
action_19 (35) = happyShift action_19
action_19 (4) = happyGoto action_20
action_19 (5) = happyGoto action_4
action_19 (6) = happyGoto action_5
action_19 (7) = happyGoto action_6
action_19 (8) = happyGoto action_7
action_19 (9) = happyGoto action_8
action_19 (10) = happyGoto action_9
action_19 _ = happyFail

action_20 (36) = happyShift action_55
action_20 _ = happyFail

action_21 (35) = happyShift action_26
action_21 _ = happyReduce_27

action_22 (35) = happyShift action_26
action_22 _ = happyReduce_26

action_23 (11) = happyShift action_2
action_23 (12) = happyShift action_10
action_23 (14) = happyShift action_11
action_23 (15) = happyShift action_12
action_23 (16) = happyShift action_13
action_23 (17) = happyShift action_14
action_23 (20) = happyShift action_15
action_23 (21) = happyShift action_16
action_23 (24) = happyShift action_17
action_23 (33) = happyShift action_18
action_23 (35) = happyShift action_19
action_23 (4) = happyGoto action_54
action_23 (5) = happyGoto action_4
action_23 (6) = happyGoto action_5
action_23 (7) = happyGoto action_6
action_23 (8) = happyGoto action_7
action_23 (9) = happyGoto action_8
action_23 (10) = happyGoto action_9
action_23 _ = happyFail

action_24 (22) = happyShift action_53
action_24 _ = happyFail

action_25 (11) = happyShift action_2
action_25 (12) = happyShift action_10
action_25 (14) = happyShift action_11
action_25 (15) = happyShift action_12
action_25 (16) = happyShift action_13
action_25 (17) = happyShift action_14
action_25 (20) = happyShift action_15
action_25 (21) = happyShift action_16
action_25 (24) = happyShift action_17
action_25 (33) = happyShift action_18
action_25 (35) = happyShift action_19
action_25 (4) = happyGoto action_52
action_25 (5) = happyGoto action_4
action_25 (6) = happyGoto action_5
action_25 (7) = happyGoto action_6
action_25 (8) = happyGoto action_7
action_25 (9) = happyGoto action_8
action_25 (10) = happyGoto action_9
action_25 _ = happyFail

action_26 (11) = happyShift action_2
action_26 (12) = happyShift action_10
action_26 (14) = happyShift action_11
action_26 (15) = happyShift action_12
action_26 (16) = happyShift action_13
action_26 (17) = happyShift action_14
action_26 (20) = happyShift action_15
action_26 (21) = happyShift action_16
action_26 (24) = happyShift action_17
action_26 (33) = happyShift action_18
action_26 (35) = happyShift action_19
action_26 (4) = happyGoto action_51
action_26 (5) = happyGoto action_4
action_26 (6) = happyGoto action_5
action_26 (7) = happyGoto action_6
action_26 (8) = happyGoto action_7
action_26 (9) = happyGoto action_8
action_26 (10) = happyGoto action_9
action_26 _ = happyFail

action_27 (14) = happyShift action_11
action_27 (15) = happyShift action_12
action_27 (20) = happyShift action_15
action_27 (21) = happyShift action_16
action_27 (24) = happyShift action_17
action_27 (33) = happyShift action_18
action_27 (35) = happyShift action_19
action_27 (10) = happyGoto action_50
action_27 _ = happyFail

action_28 (14) = happyShift action_11
action_28 (15) = happyShift action_12
action_28 (20) = happyShift action_15
action_28 (21) = happyShift action_16
action_28 (24) = happyShift action_17
action_28 (33) = happyShift action_18
action_28 (35) = happyShift action_19
action_28 (10) = happyGoto action_49
action_28 _ = happyFail

action_29 (14) = happyShift action_11
action_29 (15) = happyShift action_12
action_29 (20) = happyShift action_15
action_29 (21) = happyShift action_16
action_29 (24) = happyShift action_17
action_29 (33) = happyShift action_18
action_29 (35) = happyShift action_19
action_29 (9) = happyGoto action_48
action_29 (10) = happyGoto action_9
action_29 _ = happyFail

action_30 (14) = happyShift action_11
action_30 (15) = happyShift action_12
action_30 (20) = happyShift action_15
action_30 (21) = happyShift action_16
action_30 (24) = happyShift action_17
action_30 (33) = happyShift action_18
action_30 (35) = happyShift action_19
action_30 (9) = happyGoto action_47
action_30 (10) = happyGoto action_9
action_30 _ = happyFail

action_31 (14) = happyShift action_11
action_31 (15) = happyShift action_12
action_31 (20) = happyShift action_15
action_31 (21) = happyShift action_16
action_31 (24) = happyShift action_17
action_31 (33) = happyShift action_18
action_31 (35) = happyShift action_19
action_31 (8) = happyGoto action_46
action_31 (9) = happyGoto action_8
action_31 (10) = happyGoto action_9
action_31 _ = happyFail

action_32 (14) = happyShift action_11
action_32 (15) = happyShift action_12
action_32 (20) = happyShift action_15
action_32 (21) = happyShift action_16
action_32 (24) = happyShift action_17
action_32 (33) = happyShift action_18
action_32 (35) = happyShift action_19
action_32 (8) = happyGoto action_45
action_32 (9) = happyGoto action_8
action_32 (10) = happyGoto action_9
action_32 _ = happyFail

action_33 (14) = happyShift action_11
action_33 (15) = happyShift action_12
action_33 (20) = happyShift action_15
action_33 (21) = happyShift action_16
action_33 (24) = happyShift action_17
action_33 (33) = happyShift action_18
action_33 (35) = happyShift action_19
action_33 (8) = happyGoto action_44
action_33 (9) = happyGoto action_8
action_33 (10) = happyGoto action_9
action_33 _ = happyFail

action_34 (14) = happyShift action_11
action_34 (15) = happyShift action_12
action_34 (20) = happyShift action_15
action_34 (21) = happyShift action_16
action_34 (24) = happyShift action_17
action_34 (33) = happyShift action_18
action_34 (35) = happyShift action_19
action_34 (8) = happyGoto action_43
action_34 (9) = happyGoto action_8
action_34 (10) = happyGoto action_9
action_34 _ = happyFail

action_35 (14) = happyShift action_11
action_35 (15) = happyShift action_12
action_35 (20) = happyShift action_15
action_35 (21) = happyShift action_16
action_35 (24) = happyShift action_17
action_35 (33) = happyShift action_18
action_35 (35) = happyShift action_19
action_35 (8) = happyGoto action_42
action_35 (9) = happyGoto action_8
action_35 (10) = happyGoto action_9
action_35 _ = happyFail

action_36 (14) = happyShift action_11
action_36 (15) = happyShift action_12
action_36 (20) = happyShift action_15
action_36 (21) = happyShift action_16
action_36 (24) = happyShift action_17
action_36 (33) = happyShift action_18
action_36 (35) = happyShift action_19
action_36 (7) = happyGoto action_41
action_36 (8) = happyGoto action_7
action_36 (9) = happyGoto action_8
action_36 (10) = happyGoto action_9
action_36 _ = happyFail

action_37 (14) = happyShift action_11
action_37 (15) = happyShift action_12
action_37 (20) = happyShift action_15
action_37 (21) = happyShift action_16
action_37 (24) = happyShift action_17
action_37 (33) = happyShift action_18
action_37 (35) = happyShift action_19
action_37 (6) = happyGoto action_40
action_37 (7) = happyGoto action_6
action_37 (8) = happyGoto action_7
action_37 (9) = happyGoto action_8
action_37 (10) = happyGoto action_9
action_37 _ = happyFail

action_38 (20) = happyShift action_39
action_38 _ = happyFail

action_39 (36) = happyShift action_60
action_39 _ = happyFail

action_40 (32) = happyShift action_36
action_40 _ = happyReduce_6

action_41 (27) = happyShift action_31
action_41 (28) = happyShift action_32
action_41 (29) = happyShift action_33
action_41 (30) = happyShift action_34
action_41 (31) = happyShift action_35
action_41 _ = happyReduce_8

action_42 (23) = happyShift action_29
action_42 (24) = happyShift action_30
action_42 _ = happyReduce_10

action_43 (23) = happyShift action_29
action_43 (24) = happyShift action_30
action_43 _ = happyReduce_14

action_44 (23) = happyShift action_29
action_44 (24) = happyShift action_30
action_44 _ = happyReduce_13

action_45 (23) = happyShift action_29
action_45 (24) = happyShift action_30
action_45 _ = happyReduce_12

action_46 (23) = happyShift action_29
action_46 (24) = happyShift action_30
action_46 _ = happyReduce_11

action_47 (25) = happyShift action_27
action_47 (26) = happyShift action_28
action_47 _ = happyReduce_17

action_48 (25) = happyShift action_27
action_48 (26) = happyShift action_28
action_48 _ = happyReduce_16

action_49 (35) = happyShift action_26
action_49 _ = happyReduce_20

action_50 (35) = happyShift action_26
action_50 _ = happyReduce_19

action_51 (36) = happyShift action_59
action_51 _ = happyFail

action_52 (36) = happyShift action_58
action_52 _ = happyFail

action_53 (11) = happyShift action_2
action_53 (12) = happyShift action_10
action_53 (14) = happyShift action_11
action_53 (15) = happyShift action_12
action_53 (16) = happyShift action_13
action_53 (17) = happyShift action_14
action_53 (20) = happyShift action_15
action_53 (21) = happyShift action_16
action_53 (24) = happyShift action_17
action_53 (33) = happyShift action_18
action_53 (35) = happyShift action_19
action_53 (4) = happyGoto action_57
action_53 (5) = happyGoto action_4
action_53 (6) = happyGoto action_5
action_53 (7) = happyGoto action_6
action_53 (8) = happyGoto action_7
action_53 (9) = happyGoto action_8
action_53 (10) = happyGoto action_9
action_53 _ = happyFail

action_54 (38) = happyShift action_56
action_54 _ = happyFail

action_55 _ = happyReduce_29

action_56 (18) = happyShift action_64
action_56 _ = happyFail

action_57 (19) = happyShift action_63
action_57 _ = happyFail

action_58 (11) = happyShift action_2
action_58 (12) = happyShift action_10
action_58 (14) = happyShift action_11
action_58 (15) = happyShift action_12
action_58 (16) = happyShift action_13
action_58 (17) = happyShift action_14
action_58 (20) = happyShift action_15
action_58 (21) = happyShift action_16
action_58 (24) = happyShift action_17
action_58 (33) = happyShift action_18
action_58 (35) = happyShift action_19
action_58 (4) = happyGoto action_62
action_58 (5) = happyGoto action_4
action_58 (6) = happyGoto action_5
action_58 (7) = happyGoto action_6
action_58 (8) = happyGoto action_7
action_58 (9) = happyGoto action_8
action_58 (10) = happyGoto action_9
action_58 _ = happyFail

action_59 _ = happyReduce_22

action_60 (37) = happyShift action_61
action_60 _ = happyFail

action_61 (11) = happyShift action_2
action_61 (12) = happyShift action_10
action_61 (14) = happyShift action_11
action_61 (15) = happyShift action_12
action_61 (16) = happyShift action_13
action_61 (17) = happyShift action_14
action_61 (20) = happyShift action_15
action_61 (21) = happyShift action_16
action_61 (24) = happyShift action_17
action_61 (33) = happyShift action_18
action_61 (35) = happyShift action_19
action_61 (4) = happyGoto action_68
action_61 (5) = happyGoto action_4
action_61 (6) = happyGoto action_5
action_61 (7) = happyGoto action_6
action_61 (8) = happyGoto action_7
action_61 (9) = happyGoto action_8
action_61 (10) = happyGoto action_9
action_61 _ = happyFail

action_62 (13) = happyShift action_67
action_62 _ = happyFail

action_63 (11) = happyShift action_2
action_63 (12) = happyShift action_10
action_63 (14) = happyShift action_11
action_63 (15) = happyShift action_12
action_63 (16) = happyShift action_13
action_63 (17) = happyShift action_14
action_63 (20) = happyShift action_15
action_63 (21) = happyShift action_16
action_63 (24) = happyShift action_17
action_63 (33) = happyShift action_18
action_63 (35) = happyShift action_19
action_63 (4) = happyGoto action_66
action_63 (5) = happyGoto action_4
action_63 (6) = happyGoto action_5
action_63 (7) = happyGoto action_6
action_63 (8) = happyGoto action_7
action_63 (9) = happyGoto action_8
action_63 (10) = happyGoto action_9
action_63 _ = happyFail

action_64 (37) = happyShift action_65
action_64 _ = happyFail

action_65 (11) = happyShift action_2
action_65 (12) = happyShift action_10
action_65 (14) = happyShift action_11
action_65 (15) = happyShift action_12
action_65 (16) = happyShift action_13
action_65 (17) = happyShift action_14
action_65 (20) = happyShift action_15
action_65 (21) = happyShift action_16
action_65 (24) = happyShift action_17
action_65 (33) = happyShift action_18
action_65 (35) = happyShift action_19
action_65 (4) = happyGoto action_71
action_65 (5) = happyGoto action_4
action_65 (6) = happyGoto action_5
action_65 (7) = happyGoto action_6
action_65 (8) = happyGoto action_7
action_65 (9) = happyGoto action_8
action_65 (10) = happyGoto action_9
action_65 _ = happyFail

action_66 _ = happyReduce_2

action_67 (11) = happyShift action_2
action_67 (12) = happyShift action_10
action_67 (14) = happyShift action_11
action_67 (15) = happyShift action_12
action_67 (16) = happyShift action_13
action_67 (17) = happyShift action_14
action_67 (20) = happyShift action_15
action_67 (21) = happyShift action_16
action_67 (24) = happyShift action_17
action_67 (33) = happyShift action_18
action_67 (35) = happyShift action_19
action_67 (4) = happyGoto action_70
action_67 (5) = happyGoto action_4
action_67 (6) = happyGoto action_5
action_67 (7) = happyGoto action_6
action_67 (8) = happyGoto action_7
action_67 (9) = happyGoto action_8
action_67 (10) = happyGoto action_9
action_67 _ = happyFail

action_68 (38) = happyShift action_69
action_68 _ = happyFail

action_69 _ = happyReduce_1

action_70 _ = happyReduce_4

action_71 (38) = happyShift action_72
action_71 _ = happyFail

action_72 _ = happyReduce_3

happyReduce_1 = happyReduce 7 4 happyReduction_1
happyReduction_1 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenIdent happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Function happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_2 = happyReduce 6 4 happyReduction_2
happyReduction_2 ((HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenIdent happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Declare happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_3 = happyReduce 8 4 happyReduction_3
happyReduction_3 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (Try happy_var_3 happy_var_7
	) `HappyStk` happyRest

happyReduce_4 = happyReduce 7 4 happyReduction_4
happyReduction_4 ((HappyAbsSyn4  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (If happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_5 = happySpecReduce_1  4 happyReduction_5
happyReduction_5 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_3  5 happyReduction_6
happyReduction_6 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (Binary Or happy_var_1 happy_var_3
	)
happyReduction_6 _ _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_1  5 happyReduction_7
happyReduction_7 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_3  6 happyReduction_8
happyReduction_8 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (Binary And happy_var_1 happy_var_3
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
		 (Binary EQ happy_var_1 happy_var_3
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_3  7 happyReduction_11
happyReduction_11 (HappyAbsSyn8  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Binary LT happy_var_1 happy_var_3
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  7 happyReduction_12
happyReduction_12 (HappyAbsSyn8  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Binary GT happy_var_1 happy_var_3
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  7 happyReduction_13
happyReduction_13 (HappyAbsSyn8  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Binary LE happy_var_1 happy_var_3
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  7 happyReduction_14
happyReduction_14 (HappyAbsSyn8  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Binary GE happy_var_1 happy_var_3
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_1  7 happyReduction_15
happyReduction_15 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_3  8 happyReduction_16
happyReduction_16 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn8
		 (Binary Add happy_var_1 happy_var_3
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_3  8 happyReduction_17
happyReduction_17 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn8
		 (Binary Sub happy_var_1 happy_var_3
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  8 happyReduction_18
happyReduction_18 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_1
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  9 happyReduction_19
happyReduction_19 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Binary Mul happy_var_1 happy_var_3
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_3  9 happyReduction_20
happyReduction_20 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Binary Div happy_var_1 happy_var_3
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  9 happyReduction_21
happyReduction_21 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happyReduce 4 10 happyReduction_22
happyReduction_22 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn10  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Call happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_23 = happySpecReduce_1  10 happyReduction_23
happyReduction_23 (HappyTerminal (Digits happy_var_1))
	 =  HappyAbsSyn10
		 (Literal (IntV happy_var_1)
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  10 happyReduction_24
happyReduction_24 _
	 =  HappyAbsSyn10
		 (Literal (BoolV True)
	)

happyReduce_25 = happySpecReduce_1  10 happyReduction_25
happyReduction_25 _
	 =  HappyAbsSyn10
		 (Literal (BoolV False)
	)

happyReduce_26 = happySpecReduce_2  10 happyReduction_26
happyReduction_26 (HappyAbsSyn10  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (Unary Neg happy_var_2
	)
happyReduction_26 _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_2  10 happyReduction_27
happyReduction_27 (HappyAbsSyn10  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (Unary Not happy_var_2
	)
happyReduction_27 _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  10 happyReduction_28
happyReduction_28 (HappyTerminal (TokenIdent happy_var_1))
	 =  HappyAbsSyn10
		 (Variable happy_var_1
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  10 happyReduction_29
happyReduction_29 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (happy_var_2
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 39 39 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenKeyword "function" -> cont 11;
	TokenKeyword "if" -> cont 12;
	TokenKeyword "else" -> cont 13;
	TokenKeyword "true" -> cont 14;
	TokenKeyword "false" -> cont 15;
	TokenKeyword "var" -> cont 16;
	TokenKeyword "try" -> cont 17;
	TokenKeyword "catch" -> cont 18;
	Symbol ";" -> cont 19;
	TokenIdent happy_dollar_dollar -> cont 20;
	Digits happy_dollar_dollar -> cont 21;
	Symbol "=" -> cont 22;
	Symbol "+" -> cont 23;
	Symbol "-" -> cont 24;
	Symbol "*" -> cont 25;
	Symbol "/" -> cont 26;
	Symbol "<" -> cont 27;
	Symbol ">" -> cont 28;
	Symbol "<=" -> cont 29;
	Symbol ">=" -> cont 30;
	Symbol "==" -> cont 31;
	Symbol "&&" -> cont 32;
	Symbol "!" -> cont 33;
	Symbol "||" -> cont 34;
	Symbol "(" -> cont 35;
	Symbol ")" -> cont 36;
	Symbol "{" -> cont 37;
	Symbol "}" -> cont 38;
	_ -> happyError' (tk:tks)
	}

happyError_ 39 tk tks = happyError' tks
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


symbols = ["+", "-", "*", "/", "(", ")", "{", "}", ";", "==", "=", "<=", ">=", "<", ">", "||", "&&", "!"]
keywords = ["function", "var", "if", "else", "true", "false", "try", "catch"]
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

