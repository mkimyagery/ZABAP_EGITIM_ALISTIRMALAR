*&---------------------------------------------------------------------*
*& Report ZCM_TEST_335
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_056.

*Alıştırma – 1: Yeni bir rapor oluşturun ve kullanıcıdan 1 adet çalışan ID bilgisi alin. Yeni bir class
*oluşturun. Birinci metot çalışanın genel bilgilerini (ZCM_TABLO_1 tablosundan) tek bir satir olarak
*hazırlayıp export etsin. İkinci metot bir tablo export etsin ve bu tablonun 2 adet kolonu olsun. (YIL ve
*KULLANILAN_IZIN). İlk metottan gelen satır ve ikinci metottan gelen tabloyu kullanarak anlamlı bir
*mesaj oluşturup kullanıcıya verin. (1001 ID’sine sahip Mehmet Öztürk 2024 yılında 27 gün, 2025
*yılında 20 gün izin kaydı yapmıştır.) Raporda inline declaration ile tanımlanmış değişkenler kullanın.

PARAMETERS: p_id TYPE zcm_de_id.

DATA: gv_toplam_izin TYPE n LENGTH 3.

START-OF-SELECTION.

  DATA(go_calisan) = NEW zcmcalisan_bilgileri( ).

  "Calisan bilgilerini al.
  go_calisan->calisan_bilgilerini_al(
    EXPORTING
      iv_id                = p_id
    IMPORTING
      es_calisan_bilgileri = DATA(gs_calisan) ).

  "Calisan izin bilgilerini al.
  go_calisan->izin_bilgilerini_al(
    EXPORTING
      iv_id             = p_id
    IMPORTING
      et_izin_bilgileri = DATA(gt_izin_bilgileri) ).

  "ID hücresinde basta bulunan sifirlardan kurtul.
  SHIFT gs_calisan-id LEFT DELETING LEADING '0'.

  "Mesajin ilk bölümünü olustur.
*  CONCATENATE gs_calisan-id 'ID''sine sahip' gs_calisan-ad gs_calisan-soyad INTO DATA(gv_string_1) SEPARATED BY space.
  DATA(gv_string_1) = |{ gs_calisan-id }| & | | & |ID'sine sahip| & | | & |{ gs_calisan-ad }| & | | & |{ gs_calisan-soyad }|.


  "Izin bilgileri tablosunu gruplayarak loop et.
  "Yil bazinda gruplanmis her bir grup icin toplam kullanilmis izin günü sayisini bul.
  "Yil ve izin günü sayisini kullanarak mesajin orta kismini olustur ve ilk kismiyla birlestir.
  LOOP AT gt_izin_bilgileri INTO DATA(gs_izin) GROUP BY ( yil = gs_izin-yil )
                                               INTO DATA(gt_group).

    LOOP AT GROUP gt_group INTO DATA(gs_group).
      DATA(gv_yil) = gs_group-yil.

      gv_toplam_izin = gv_toplam_izin + gs_group-kul_izin.
    ENDLOOP.

    "Izin günü sayisini type N tanimlamak zorunda kaldik.
    "Bu nedenle baslarinda gereksiz 0 olustu. Bu 0'lardan kurtul.
    SHIFT gv_toplam_izin LEFT DELETING LEADING '0'.

    CONCATENATE gv_yil 'yilinda' gv_toplam_izin 'gün,' INTO DATA(gv_sting_2) SEPARATED BY space.

    CONCATENATE gv_string_1 gv_sting_2 INTO gv_string_1 SEPARATED BY space.

    CLEAR: gv_toplam_izin.

  ENDLOOP.

  "Buraya kadar hazirlanan mesaj textinin sonundaki virgülden kurtul.
  DATA(gv_karakter_sayisi) = strlen( gv_string_1 ) - 1.
  gv_string_1 = gv_string_1(gv_karakter_sayisi).

  "Mesajin son kismini ekle.
  CONCATENATE gv_string_1 'izin kaydı yapmıştır.' INTO gv_string_1 SEPARATED BY space.

  "Mesaji kullaniciya göster.
  MESSAGE gv_string_1 TYPE 'I'.
