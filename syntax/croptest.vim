" Vim syntax file
" Language:         CockroachDB opt tests
" Maintainer:       Radu Berinde <radu@cockroachlabs.com>
"
" Recommended in .vimrc:
"    autocmd BufNewFile,BufRead */sql/opt/testdata/* set filetype=cropttest tw=0

if exists("b:current_syntax")
  finish
endif

syn sync fromstart

syn match Comment display '#.*$' contains=Todo

syn match directive       display '[^ ]*\(build\|exec\|opt\|memo\|norm\|optsteps\|exploretrace\)[^ ]*' skipwhite nextgroup=vars,index
syn match vars            contained display 'vars' nextgroup=varVals
syn match varVals         contained display '=([^)]*)' skipwhite nextgroup=index
syn match index           contained display 'inverted-index'

syn match Number	'\<\d\+\>#\='

"syn region Constant start=+'+ end=+'+

syn match	separator '^----$'
syn region results matchgroup=separator start='^----$' end='^$' contains=badWhitespace,number,parens,braces,constant,valueKeyword fold

" Highlight trailing whitespace and tabs.
"syn match badWhitespace display '\s\+$'
"syn match badWhitespace display '\t'

syn match parens display '[()]'
syn match braces display '[{}]'

hi def link parens        Identifier
hi def link braces        Special
hi def link separator     Special
hi def link stmt          Special
hi def link stmtOk        Identifier
hi def link stmtErr       Identifier
hi def link errorStr      Constant
hi def link directive     Special
hi def link vars          Keyword
hi def link index         Keyword
hi def link badWhitespace ErrorMsg

syn keyword Todo TODO XXX

syn case ignore

syn keyword valueKeyword FALSE TRUE NULL

syn keyword sqlKeyword ACTION ADD ALTER AT BACKUP BEGIN BLOB BY CASCADE COLUMNS COMMIT COMMITTED CONFLICT CONSTRAINTS COPY COVERING CUBE CURRENT CYCLE
syn keyword sqlKeyword DATA DATABASE DATABASES DAY DEALLOCATE DELETE DOUBLE DROP ENCODING EXECUTE EXPLAIN FILTER FIRST FOLLOWING FORCE_INDEX GRANTS
syn keyword sqlKeyword HELP HIGH HOUR INCREMENTAL INDEXES INSERT INT2VECTOR INTERLEAVE ISOLATION KEY KEYS
syn keyword sqlKeyword LC_COLLATE LC_CTYPE LEVEL LOCAL LOW MATCH MINUTE MONTH NAMES NAN NEXT NO NORMAL NO_INDEX_JOIN NULLS OF OFF OID OPTIONS ORDINALITY OVER
syn keyword sqlKeyword PARENT PARTIAL PARTITION PASSWORD PRECEDING PREPARE PRIORITY RANGE RANGES READ RECURSIVE REF REGCLASS REGPROC REGPROCEDURE REGNAMESPACE
syn keyword sqlKeyword REGTYPE RELEASE RENAME REPEATABLE RESTORE RESTRICT REVOKE ROLLBACK ROLLUP ROWS STATUS SAVEPOINT SEARCH SECOND SERIALIZABLE SESSION
syn keyword sqlKeyword SET SHOW SIMPLE SNAPSHOT SQL START STDIN STORING STRICT SPLIT SYSTEM TABLES TEMPLATE TEXT TRANSACTION TRUNCATE TYPE UNBOUNDED UNCOMMITTED UNKNOWN
syn keyword sqlKeyword UPDATE UPSERT USERS VALID VALIDATE VALUE VARYING WITHIN WITHOUT YEAR ZONE

syn keyword sqlReserved ALL ANALYSE ANALYZE AND ANY ARRAY AS ASC ASYMMETRIC BOTH CASE CAST CHECK COLLATE COLUMN CONSTRAINT CREATE
syn keyword sqlReserved CURRENT_CATALOG CURRENT_DATE CURRENT_ROLE CURRENT_TIME CURRENT_TIMESTAMP CURRENT_USER DEFAULT DEFERRABLE
syn keyword sqlReserved DESC DISTINCT DO ELSE END EXCEPT FAMILY FETCH FOR FOREIGN FROM GRANT GROUP HAVING IN INDEX
syn keyword sqlReserved INITIALLY INTERSECT INTO LATERAL LEADING LIMIT LOCALTIME LOCALTIMESTAMP NOT NOTHING OFFSET ON ONLY OR
syn keyword sqlReserved ORDER PLACING PRIMARY REFERENCES RETURNING SELECT SESSION_USER SOME SYMMETRIC TABLE THEN TO TRAILING 
syn keyword sqlReserved UNION UNIQUE USER USING VARIADIC VIEW WHEN WHERE WINDOW WITH

syn keyword sqlType ANNOTATE_TYPE BETWEEN BIGINT BIGSERIAL BIT BOOL BOOLEAN BYTEA BYTES CHAR CHARACTER CHARACTERISTICS COALESCE DATE
syn keyword sqlType DEC DECIMAL EXISTS EXTRACT EXTRACT_DURATION FLOAT GREATEST GROUPING HISTOGRAM IF IFNULL INT INT8 INT64 INTEGER INTERVAL JSON JSONB LEAST
syn keyword sqlType NAME NULLIF NUMERIC OUT OVERLAY POSITION PRECISION REAL ROW SEQUENCE SERIAL SMALLINT SMALLSERIAL STATISTICS STRING SUBSTRING TIME TIMESTAMP
syn keyword sqlType TIMESTAMPTZ TREAT TRIM VALUES VARCHAR

syn keyword sqlKeyword COLLATION CROSS FULL INNER ILIKE IS JOIN LEFT LIKE NATURAL OUTER OVERLAPS RIGHT SIMILAR

syn keyword sqlFunc MIN MAX COUNT SUM_INT AVG SUM STDDEV VARIANCE BOOL_AND BOOL_OR ARRAY_AGG


hi def link valueKeyword Constant
hi def link sqlFunc	     Function
hi def link sqlType	     Type
hi def link sqlReserved  Keyword
hi def link sqlKeyword	 Keyword

let b:current_syntax = "cropttest"

