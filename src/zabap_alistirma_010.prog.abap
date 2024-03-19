*&---------------------------------------------------------------------*
*& Report ZCM_TEST_145
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_alistirma_010.

*Alıştırma – 1: Yeni bir rapor oluşturun ve kullanıcıdan 2 adet sayı alin. Yeni bir Class oluşturun. Class
*içerisinde 1 adet metot olsun. (Instance-Public) Metodun sayı tipinde 2 adet import parametresi olsun,
*yine sayı tipinde 1 adet export parametresi olsun. Metot kendisine verilen birinci sayıyı (kendisine
*verilen ikinci sayı kadar) kendisiyle çarpsın. (Örnek: metoda sırasıyla 10 ve 3 sayıları verildiyse, metot
*10 sayısını kendisiyle 3 kere çarpacak ve elde ettiği sonucu export parametresine kaydedecek.) elde
*ettiğiniz sonucu ekrana yazdırın.

PARAMETERS: p_num_01 TYPE int4,
            p_num_02 TYPE int4.

DATA: go_class  TYPE REF TO zalistirma_cls_01,
      gv_result TYPE int4.

START-OF-SELECTION.

  CREATE OBJECT go_class.

  go_class->method_01(
    EXPORTING
      iv_number_01 = p_num_01
      iv_number_02 = p_num_02
    IMPORTING
      ev_result    = gv_result ).

  WRITE: gv_result.
