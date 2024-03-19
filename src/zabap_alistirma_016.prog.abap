*&---------------------------------------------------------------------*
*& Report ZCM_TEST_159
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_016.

DATA: gs_structure TYPE zcm_s_ogr_bilgi_2,
      gt_table TYPE TABLE OF zcm_s_ogr_bilgi_2,
      gs_ders_bilgi TYPE zcm_s_ders_bilgi.

START-OF-SELECTION.

  gs_structure-ogrenci_id = '10001'.
  gs_structure-ad         = 'Mehmet'.
  gs_structure-soyad      = 'Öztürk'.
  gs_structure-adres-sokak_adi    = 'Bahar Cd.'.
  gs_structure-adres-ev_no        = '25/A'.
  gs_structure-adres-posta_kutusu = '45453'.
  gs_structure-adres-sehir        = 'Istanbul'.

  gs_ders_bilgi-ders_adi      = 'Edebiyat'.
  gs_ders_bilgi-vize_1        = 70.
  gs_ders_bilgi-vize_2        = 90.
  gs_ders_bilgi-vize_3        = 80.
  gs_ders_bilgi-final         = 85.
  gs_ders_bilgi-basari_durumu = abap_true.
  APPEND gs_ders_bilgi TO gs_structure-dersler.
  CLEAR: gs_ders_bilgi.

  gs_ders_bilgi-ders_adi      = 'Matematik'.
  gs_ders_bilgi-vize_1        = 50.
  gs_ders_bilgi-vize_2        = 80.
  gs_ders_bilgi-vize_3        = 100.
  gs_ders_bilgi-final         = 60.
  gs_ders_bilgi-basari_durumu = abap_true.
  APPEND gs_ders_bilgi TO gs_structure-dersler.
  CLEAR: gs_ders_bilgi.

  APPEND gs_structure to gt_table.
  CLEAR: gs_structure.

  gs_structure-ogrenci_id = '10002'.
  gs_structure-ad         = 'Ali'.
  gs_structure-soyad      = 'Yilmaz'.
  gs_structure-adres-sokak_adi    = 'Bahar Cd.'.
  gs_structure-adres-ev_no        = '25/A'.
  gs_structure-adres-posta_kutusu = '45453'.
  gs_structure-adres-sehir        = 'Istanbul'.

  gs_ders_bilgi-ders_adi      = 'Fizik'.
  gs_ders_bilgi-vize_1        = 70.
  gs_ders_bilgi-vize_2        = 90.
  gs_ders_bilgi-vize_3        = 80.
  gs_ders_bilgi-final         = 85.
  gs_ders_bilgi-basari_durumu = abap_true.
  APPEND gs_ders_bilgi TO gs_structure-dersler.
  CLEAR: gs_ders_bilgi.

  gs_ders_bilgi-ders_adi      = 'Kimya'.
  gs_ders_bilgi-vize_1        = 50.
  gs_ders_bilgi-vize_2        = 80.
  gs_ders_bilgi-vize_3        = 100.
  gs_ders_bilgi-final         = 60.
  gs_ders_bilgi-basari_durumu = abap_true.
  APPEND gs_ders_bilgi TO gs_structure-dersler.
  CLEAR: gs_ders_bilgi.

  APPEND gs_structure to gt_table.
  CLEAR: gs_structure.

  BREAK-POINT.
