DO $$ 
DECLARE 
    r RECORD;
BEGIN 
    -- Rinomina le tabelle
    FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'public' AND tablename <> lower(tablename)) LOOP 
        EXECUTE 'ALTER TABLE public."' || r.tablename || '" RENAME TO "' || lower(r.tablename) || '"'; 
    END LOOP; 

    -- Rinomina le colonne
    FOR r IN (SELECT table_name, column_name FROM information_schema.columns WHERE table_schema = 'public' AND column_name <> lower(column_name)) LOOP 
        EXECUTE 'ALTER TABLE public."' || r.table_name || '" RENAME COLUMN "' || r.column_name || '" TO "' || lower(r.column_name) || '"'; 
    END LOOP; 
END $$;
