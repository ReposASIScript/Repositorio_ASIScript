/* Formatted on 2014/06/04 17:43 (Formatter Plus v4.8.8) */
SELECT   DECODE (data_type,
                 'NUMBER', 'wrp_k_kernel.cnst_number_type',
                 'INTEGER', 'wrp_k_kernel.cnst_integer_type',
                 'VARCHAR2', 'wrp_k_kernel.cnst_varchar2_type',
                 'VARCHAR', 'wrp_k_kernel.cnst_varchar_type',
                 'CHAR', 'wrp_k_kernel.cnst_varchar_type',
                 'DATE', 'wrp_k_kernel.cnst_date_type',
                 'CLOB', 'wrp_k_kernel.cnst_clob_type',
                 'CURSOR REF ', 'wrp_k_kernel.cnst_ref_cursor_type',
                 'CURSOR REF ', 'wrp_k_kernel.cnst_ref_cursor_type',
                 'XMLTYPE ', 'wrp_k_kernel.cnst_xml_type'
                ) data_type1,
         a.*
    FROM SYS.all_arguments a
   WHERE package_name = UPPER('&nombre_paquete') -- 'SP_K_QUERYS_REP_FORMULARIOS'
     AND object_name  = UPPER('&nombre_objeto')  -- 'SP_P_PATRONO_CLIENTE'
     AND owner        = NVL(UPPER('&nombre_objeto'),USER)  -- 'DSVFSV'
ORDER BY POSITION;