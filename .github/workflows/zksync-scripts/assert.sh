#!/bin/bash

. contracts/utils/colors.sh #for ANSI colors

echo "Asserting values"

assert() {
  #Usage: assert <variable_name> <expected> <obtained>
  if [ $2 = $3 ] ; then
    printf "${GREEN}✓ $1 passed.${RESET}\n"
  else
    printf "${RED}x $1 assertion failed: Expected value: $2, Obtained value: $3.${RESET}\n"
  fi
}

#setorder
echo setOrder
assert BALANCE_USER_L2_BEFORE_SETORDER $BALANCE_USER_L2_BEFORE_SETORDER 1000000000000002977607
assert BALANCE_ESCROW_L2_BEFORE_SETORDER $BALANCE_ESCROW_L2_BEFORE_SETORDER 0
assert BALANCE_USER_L2_AFTER_SETORDER $BALANCE_USER_L2_AFTER_SETORDER 99999999999800292778275
assert BALANCE_ESCROW_L2_AFTER_SETORDER $BALANCE_ESCROW_L2_AFTER_SETORDER 2

#transfer
echo transfer
assert BALANCE_MM_L1_BEFORE_TRANSFER $BALANCE_MM_L1_BEFORE_TRANSFER 99999998999999999999994843134499267961
assert BALANCE_USER_L1_BEFORE_TRANSFER $BALANCE_USER_L1_BEFORE_TRANSFER 0
assert BALANCE_MM_L1_AFTER_TRANSFER $BALANCE_MM_L1_AFTER_TRANSFER 99999998999999999999994843134499267961
assert BALANCE_USER_L1_AFTER_TRANSFER $BALANCE_USER_L1_AFTER_TRANSFER 1990000000000000000

#claimpeyment
echo claimPayment
assert BALANCE_MM_L1_BEFORE_CLAIMPAYMENT $BALANCE_MM_L1_BEFORE_CLAIMPAYMENT 99999998999999999999994843134499267961
assert BALANCE_MM_L2_BEFORE_CLAIMPAYMENT $BALANCE_MM_L2_BEFORE_CLAIMPAYMENT 1000000000000002977607
assert BALANCE_ESCROW_L2_BEFORE_CLAIMPAYMENT $BALANCE_ESCROW_L2_BEFORE_CLAIMPAYMENT 2
assert BALANCE_MM_L1_AFTER_CLAIMPAYMENT $BALANCE_MM_L1_AFTER_CLAIMPAYMENT 99999998999999999999994843134499267961
assert BALANCE_MM_L2_AFTER_CLAIMPAYMENT $BALANCE_MM_L2_AFTER_CLAIMPAYMENT 1000000000002002977607
assert BALANCE_ESCROW_L2_AFTER_CLAIMPAYMENT $BALANCE_ESCROW_L2_AFTER_CLAIMPAYMENT 0
