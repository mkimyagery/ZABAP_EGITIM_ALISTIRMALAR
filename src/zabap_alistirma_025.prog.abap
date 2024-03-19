*&---------------------------------------------------------------------*
*& Report ZCM_TEST_44
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
*Alıştırma -2: Yeni bir program oluşturun. 1 adet parametre tanımlayın ve kullanıcıdan 1 ID alin.
*Program içerisinde bir satir tanımlayın. Satirin hücreleri sırasıyla “Öğrenci ID”, “Öğrenci Adi”, “Öğrenci
*Soyadı”, “Ders”, “Alınan Not” ve “Basari Durumu” olsun. Bu satir ile ayni yapıya sahip bir internal tablo
*tanımlayın. Satiri kendi üreteceğiniz veriyle 10 kere doldurun ve her doldurmadan sonra INSERT
*komutu ile internal tabloya kaydedin. Daha sonra secim ekranından (selection screen) gelecek bilgiye
*göre internal tabloyu Read Table komutu ile okuyun ve ekrana yazdırın. (Kullanıcı hangi ID’yi girdiyse
*tablodaki ilgili satir Read Table komutu ile okunup ekrana yazdırılacak) (Parametre için selection screen
*oluşturun ve başlığını tanımlayın). (Sorted Table ile)

REPORT zabap_alistirma_025.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS: p_id TYPE n LENGTH 6 OBLIGATORY.
SELECTION-SCREEN END OF BLOCK a1.

TYPES: BEGIN OF gty_structure,
         id      TYPE n LENGTH 6,
         name    TYPE c LENGTH 30,
         surname TYPE c LENGTH 30,
         lesson  TYPE c LENGTH 20,
         mark    TYPE n LENGTH 3,
         success TYPE c LENGTH 12,
       END OF gty_structure.

DATA: gs_structure TYPE gty_structure,
      gt_table     TYPE SORTED TABLE OF gty_structure WITH UNIQUE KEY id.

START-OF-SELECTION.

*  IF p_id IS INITIAL.
*    MESSAGE TEXT-002 TYPE 'I'." DISPLAY LIKE 'E'.
*    EXIT.
*  ENDIF.

  SHIFT p_id LEFT DELETING LEADING '0'.

  IF strlen( p_id ) NE 6.
    MESSAGE TEXT-002 TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  gs_structure-id      = 200003.
  gs_structure-name    = 'ALI'.
  gs_structure-surname = 'CENGIZ'.
  gs_structure-lesson  = 'MATH'.
  gs_structure-mark    = '70'.
  gs_structure-success = 'Successful'.

  INSERT gs_structure INTO TABLE gt_table.
  CLEAR: gs_structure.

  gs_structure-id      = 200001.
  gs_structure-name    = 'VELI'.
  gs_structure-surname = 'CENGIZ'.
  gs_structure-lesson  = 'MATH'.
  gs_structure-mark    = '80'.
  gs_structure-success = 'Successful'.

  INSERT gs_structure INTO TABLE gt_table.
  CLEAR: gs_structure.

  gs_structure-id      = 200002.
  gs_structure-name    = 'MUSTAFA'.
  gs_structure-surname = 'CENGIZ'.
  gs_structure-lesson  = 'MATH'.
  gs_structure-mark    = '40'.
  gs_structure-success = 'Unsuccessful'.

  INSERT gs_structure INTO TABLE gt_table.
  CLEAR: gs_structure.

  gs_structure-id      = 200006.
  gs_structure-name    = 'MAHMUT'.
  gs_structure-surname = 'CENGIZ'.
  gs_structure-lesson  = 'MATH'.
  gs_structure-mark    = '100'.
  gs_structure-success = 'Successful'.

  INSERT gs_structure INTO TABLE gt_table.
  CLEAR: gs_structure.

  gs_structure-id      = 200004.
  gs_structure-name    = 'SALIHA'.
  gs_structure-surname = 'CENGIZ'.
  gs_structure-lesson  = 'MATH'.
  gs_structure-mark    = '30'.
  gs_structure-success = 'Unsuccessful'.

  INSERT gs_structure INTO TABLE gt_table.
  CLEAR: gs_structure.

  gs_structure-id      = 200010.
  gs_structure-name    = 'GÜLCIN'.
  gs_structure-surname = 'CENGIZ'.
  gs_structure-lesson  = 'MATH'.
  gs_structure-mark    = '90'.
  gs_structure-success = 'Successful'.

  INSERT gs_structure INTO TABLE gt_table.
  CLEAR: gs_structure.

  gs_structure-id      = 200008.
  gs_structure-name    = 'SÜREYYA'.
  gs_structure-surname = 'CENGIZ'.
  gs_structure-lesson  = 'MATH'.
  gs_structure-mark    = '85'.
  gs_structure-success = 'Successful'.

  INSERT gs_structure INTO TABLE gt_table.
  CLEAR: gs_structure.

  gs_structure-id      = 200009.
  gs_structure-name    = 'MEHMET'.
  gs_structure-surname = 'CENGIZ'.
  gs_structure-lesson  = 'MATH'.
  gs_structure-mark    = '50'.
  gs_structure-success = 'Unsuccessful'.

  INSERT gs_structure INTO TABLE gt_table.
  CLEAR: gs_structure.

  gs_structure-id      = 200005.
  gs_structure-name    = 'ERKIN'.
  gs_structure-surname = 'CENGIZ'.
  gs_structure-lesson  = 'MATH'.
  gs_structure-mark    = '20'.
  gs_structure-success = 'Unsuccessful'.

  INSERT gs_structure INTO TABLE gt_table.
  CLEAR: gs_structure.

  gs_structure-id      = 200007.
  gs_structure-name    = 'SEFIK'.
  gs_structure-surname = 'CENGIZ'.
  gs_structure-lesson  = 'MATH'.
  gs_structure-mark    = '60'.
  gs_structure-success = 'Successful'.

  INSERT gs_structure INTO TABLE gt_table.
  CLEAR: gs_structure.

  READ TABLE gt_table INTO gs_structure WITH TABLE KEY id = p_id.
  IF sy-subrc IS INITIAL.
    WRITE: gs_structure-id,  gs_structure-name, gs_structure-surname,
           gs_structure-lesson, gs_structure-mark, gs_structure-success.
  ENDIF.
