*&---------------------------------------------------------------------*
*& Report ZCM_TEST_62
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_034.

DATA: gs_sflight TYPE sflight,
      gt_sflight TYPE TABLE OF sflight.

START-OF-SELECTION.

  SELECT * FROM sflight INTO TABLE gt_sflight.

  LOOP AT gt_sflight INTO gs_sflight.
    WRITE: / gs_sflight-carrid,
             gs_sflight-connid,
             gs_sflight-fldate,
             gs_sflight-price,
             gs_sflight-currency,
             gs_sflight-planetype,
             gs_sflight-seatsmax,
             gs_sflight-seatsocc,
             gs_sflight-paymentsum,
             gs_sflight-seatsmax_b,
             gs_sflight-seatsocc_b,
             gs_sflight-seatsmax_f.
    SKIP.
    CLEAR: gs_sflight.
  ENDLOOP.
