LOAD DATA
   INFILE 'book.dat'
   REPLACE INTO TABLE book
   (
   book_title POSITION(1) CHAR(35),
   book_price POSITION(37) ZONED(4,2)
              "price_check(:book_price,:book_pages)",
   book_pages POSITION(42) INTEGER EXTERNAL(3),
   book_id "book_seq.nextval"
   )
