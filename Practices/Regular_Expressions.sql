SELECT REGEXP_COUNT(testcol, '2a', 1, 'i') RESULT FROM test
/
SELECT REGEXP_COUNT(testcol, 'e', 1, 'i') RESULT FROM test
/
SELECT REGEXP_INSTR('500 Oracle Pkwy, Redwood Shores, CA', '[o][[:alpha:]]{3}', 1, 1, 0, 'i') RESULT FROM DUAL
/
SELECT REGEXP_INSTR('500 Oracle Pkwy, Redwood Shores, CA', '[o][[:alpha:]]{3}', 1, 1, 1, 'i') RESULT FROM DUAL
/
SELECT REGEXP_INSTR('500 Oracle Pkwy, Redwood Shores, CA', '[o][[:alpha:]]{3}', 1, 2, 0, 'i') RESULT FROM DUAL
/
SELECT REGEXP_INSTR('500 Oracle Pkwy, Redwood Shores, CA', '[o][[:alpha:]]{3}', 1, 2, 1, 'i') RESULT FROM DUAL
/
SELECT REGEXP_INSTR('We are trying to make the subject easier.', 'tr(y(ing)?|(ied)|(ies))') RESULTNUM FROM DUAL
/
SELECT testcol, REGEXP_INSTR(testcol, 'ab', 1, 1, 0, 'i', 0) FROM test
/
SELECT testcol, REGEXP_INSTR(testcol, 'ab', 1, 1, 0, 'i', 1) FROM test
/
SELECT testcol, REGEXP_INSTR(testcol, 'a(b)', 1, 1, 0, 'i', 1) FROM test
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:alnum:]]')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:alnum:]]{3}')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:alnum:]]{5}')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:alpha:]]')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:alpha:]]{3}')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:alpha:]]{5}')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:cntrl:]]{1}')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:digit:]]')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:digit:]]{3}')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:digit:]]{5}')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:lower:]]')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:lower:]]{2}')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:lower:]]{3}')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:lower:]]{5}')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:print:]]{5}')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:print:]]{6}')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:print:]]{7}')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:punct:]]')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:space:]]')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:space:]]{2}')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:space:]]{3}')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:space:]]{5}')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:upper:]]')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:upper:]]{2}')
/
SELECT * FROM test WHERE REGEXP_LIKE(testcol, '[[:upper:]]{3}')
/
SELECT testcol FROM test WHERE REGEXP_LIKE(testcol, '^ab*')
/
SELECT testcol FROM test WHERE REGEXP_LIKE(testcol, '^..a.')
/
SELECT testcol FROM test WHERE REGEXP_LIKE(testcol, '([az])\1', 'i')
/
SELECT testcol FROM test WHERE REGEXP_LIKE(testcol, '^Ste(v|ph)en$')
/
SELECT ssn_col FROM ssn_test WHERE REGEXP_LIKE(ssn_col,'^[0-9]{3}-[0-9]{2}-[0-9]{4}$')
/
SELECT testcol, REGEXP_REPLACE(testcol,'([[:digit:]]{3})\.([[:digit:]]{3})\.([[:digit:]]{4})','(\1) \2-\3') RESULT FROM test WHERE LENGTH(testcol) = 12
/
SELECT testcol, REGEXP_REPLACE(testcol, '(.)', '\1 ') RESULT FROM test WHERE testcol like 'S%'
/
SELECT REGEXP_REPLACE('500    Oracle    Parkway, Redwood    Shores, CA', '( ){2,}', ' ') RESULT FROM DUAL
/
SELECT REGEXP_REPLACE('George McGovern', '([[:lower:]])([[:upper:]])', '\1 \2') CITY FROM DUAL
/
SELECT REGEXP_REPLACE('We are trying to make the subject easier.','\.',' for you.') REGEXT_SAMPLE FROM DUAL
/
SELECT LENGTH(testcol) len, testcol origval, REGEXP_REPLACE(testcol, '\W+$', ' ') newval, LENGTH(REGEXP_REPLACE(testcol, '\W+$', ' ')) newlen FROM t
/