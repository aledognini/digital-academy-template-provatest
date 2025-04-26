USING tipi;
USING Libreria;

PROGRAM MainProgram

    VAR
        n_mag : INT:=3; // numero magazzini
        nastri : ARRAY[1..3] OF nastro;
        deviatori : ARRAY[1..3] OF deviatore;
        magazzini : ARRAY[1..3+1] OF magazzino;
        PLCinizializzato : BOOL := FALSE; // il PLC va inizializzato solo una volta altrimenti il test non funziona
    END_VAR

    VAR_TEMP
        i:INT;
    END_VAR


    IF NOT PLCinizializzato THEN // il PLC va inizializzato solo una volta altrimenti il test non funziona
        FOR i := 1 TO n_mag DO // inizializzare componenti
            nastri[i].Init(i);   
            deviatori[i].Init(i);
            magazzini[i].Init(i); 
        END_FOR;
        magazzini[n_mag+1].Init(n_mag+1); //inizializzazione magazzino scarti
        
        PLCinizializzato := TRUE; // il PLC è stato inizializzato
    END_IF;

    FOR i := 1 TO n_mag DO
        
        // controllo del deviatore
        IF deviatori[i].sensore = TRUE AND deviatori[i].chiuso = FALSE THEN
            deviatori[i].ChiudiDeviatore();
        ELSIF deviatori[i].sensore = FALSE AND deviatori[i].chiuso = TRUE THEN
            deviatori[i].ApriDeviatore();
        END_IF;

    END_FOR;


    

END_PROGRAM
