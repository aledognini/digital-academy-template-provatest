USING AxUnit.Assert;
USING tipi;
USING Libreria;


NAMESPACE Test
    {TestFixture}
    CLASS MyTestFixture

        VAR
            main : MainProgram;
            pacchiTest : ARRAY[1..10] OF colore := [
                colore#Red, colore#Green, colore#Blue, colore#Yellow, colore#Orange,
                colore#Red, colore#Green, colore#Blue, colore#Yellow, colore#Orange
            ]; //introduco 10 pacchi
            tempoAttesa : TIME;
            indexColor : INT;
        END_VAR


        {Test}
        METHOD PUBLIC SimulaPacchi

            VAR
                i : INT;
            END_VAR

            FOR i := 1 TO 10 DO
                // Attendi tempo in base al colore. Il primo magazzino è quello degli scarti e ci si mette 1 secondo a raggiungerlo.
                CASE pacchiTest[i] OF
                    colore#Red:     tempoAttesa := T#1s; indexColor := 1;
                    colore#Orange:  tempoAttesa := T#2s; indexColor := 2;
                    colore#Yellow:  tempoAttesa := T#3s; indexColor := 3;
            
                    ELSE tempoAttesa := T#4s; // I pacchi green, blue, indigo e violet finiscono nel magazzino degli scarti.
                END_CASE;
                WAIT(tempoAttesa);
            
                // Attiva il sensore di presenza del deviatore giusto 
                // (Per esempio il sensore di presenza del deviatore dei pacchi rossi si attiva in presenza di un pacco rosso)
                main.deviatori[indexColor].sensore := TRUE;
            
                // richiamo il main
                main(); 
                WAIT(T#100ms); // aspetto che il main finisca di essere compilato 
                // in teoria il main dovrebbe chiudere il deviatore

                // CONTROLLA se il deviatore è stato chiuso
                IF NOT main.deviatori[indexColor].CntrlChiudi THEN
                    Fail('Errore: il deviatore non è stato chiuso!');
                END_IF;

                main.deviatori[indexColor].chiuso := TRUE; //il deviatore è stato chiuso
                main.deviatori[indexColor].sensore := FALSE; //il deviatore non vede più il pacco
                main.nastri[indexColor].isEmpty := FALSE; //il pacco è stato deviato sul nastro

                // richiamo il main
                main(); 
                WAIT(T#100ms); // aspetto che il main finisca di essere compilato



                //codice da completare...





            END_FOR;
        END_METHOD
    END_CLASS
END_NAMESPACE



