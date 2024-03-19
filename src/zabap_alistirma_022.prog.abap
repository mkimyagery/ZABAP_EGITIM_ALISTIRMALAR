*&---------------------------------------------------------------------*
*& Report ZCM_TEST_218
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZABAP_ALISTIRMA_022.

PARAMETERS: p_sifre TYPE c LENGTH 12 LOWER CASE.

START-OF-SELECTION.

SHIFT p_sifre RIGHT DELETING TRAILING space.
SHIFT p_sifre LEFT DELETING LEADING space.

IF p_sifre NA '!"§$%&/()'.
  BREAK-POINT.
ENDIF.

IF p_sifre CA ' '.
  BREAK-POINT.
ENDIF.

IF p_sifre NA '1234567890 '.
  BREAK-POINT.
ENDIF.

IF p_sifre NA 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.
  BREAK-POINT.
ENDIF.

IF p_sifre NA 'abcdefghijklmnopqrstuvwxyz'.
  BREAK-POINT.
ENDIF.

IF strlen( p_sifre ) < 8.
  BREAK-POINT.
ENDIF.
