CREATE OR REPLACE FUNCTION price_check
                          (price_in NUMBER, pages_in NUMBER)
RETURN NUMBER IS
   min_price NUMBER;
BEGIN
   /* Retrieve the mininum price for the number of pages in question. */
   SELECT ppt_min_price INTO min_price
   FROM price_page_threshold
   WHERE pages_in >= ppt_pages
   AND ppt_pages = (
      SELECT MAX(ppt_pages)
      FROM price_page_threshold
      WHERE pages_in >= ppt_pages);

   /* Return the greater of the minimum or the book price. */
   RETURN GREATEST(min_price,price_in);
END;
/

