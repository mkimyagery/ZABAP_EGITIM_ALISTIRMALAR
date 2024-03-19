*&---------------------------------------------------------------------*
*& Report ZCM_TEST_158
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZABAP_ALISTIRMA_015.

DATA: gs_structure TYPE zcm_s_ogr_bilgi.

START-OF-SELECTION.

gs_structure-ogrenci_id = '10001'.
gs_structure-ad         = 'Mehmet'.
gs_structure-soyad      = 'Öztürk'.
gs_structure-adres-sokak_adi     = 'Bahar Caddesi'.
gs_structure-adres-ev_no         = '25/A'.
gs_structure-adres-posta_kutusu  = '45453'.
gs_structure-adres-sehir         = 'Istanbul'.
gs_structure-dersler-ders_1 = 'Edebiyat'.
gs_structure-dersler-ders_2 = 'Matematik'.
gs_structure-dersler-ders_3 = 'Kimya'.
gs_structure-dersler-ders_4 = 'Müzik'.
gs_structure-dersler-ders_5 = 'Din Kül. ve Ahlak Bilg.'.

BREAK-POINT.
