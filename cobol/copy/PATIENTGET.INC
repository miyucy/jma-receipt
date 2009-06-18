           02  PATIENTGET.
            03  PGET-REQUEST.
              04  PGET-ARGUMENTS.
                05  PGET-ID PIC X(20).
              04  PGET-METHODTYPE PIC X(100).
              04  PGET-CONTENT-TYPE   PIC X(100).
              04  PGET-CONTENT-LENGTH PIC X(100).
              04  PGET-BODY   PIC X(1024).
            03  PGET-RESPONSE.
              04  PGET-INFORMATION-DATE   PIC X(8).
              04  PGET-INFORMATION-TIME   PIC X(6).
              04  PGET-API-RESULT PIC X(2).
              04  PGET-API-RESULT-MSG PIC X(100).
              04  PGET-RESKEY PIC X(100).
              04  PGET-PATIENT-INFOMATION.
                05  PGET-NAME   PIC X(100).
                05  PGET-KANANAME   PIC X(100).
                05  PGET-BIRTHDAY   PIC X(8).
                05  PGET-SEX    PIC X(1).
                05  PGET-ADDRESS-INFO.
                  06  PGET-HOME-ZIP-CODE  PIC X(7).
                  06  PGET-HOME-ADDRESSES PIC X(100).
                05  PGET-INSURANCE-INFO     OCCURS  4 TIMES.
                  06  PGET-MAIN-INSURANCE-CLASS   PIC X(10).
                  06  PGET-MAIN-INSURANCE-NUMBER  PIC X(10).
                  06  PGET-MAIN-INSURANCE-NAME    PIC X(10).
                  06  PGET-MAIN-MARK  PIC X(80).
                  06  PGET-MAIN-NUMBER    PIC X(80).
                  06  PGET-MAIN-CONTINUATION  PIC X(10).
                  06  PGET-MAIN-ASSISTANCE    PIC X(10).
                  06  PGET-MAIN-FAMILY    PIC X(10).
                  06  PGET-MAIN-POLICYHOLDER  PIC X(100).
                  06  PGET-MAIN-START-DATE    PIC X(10).
                  06  PGET-MAIN-END-DATE  PIC X(10).
                  06  PGET-PUBLIC-INSURANCE-INFO      OCCURS  3 TIMES.
                    07  PGET-INSURANCE-NUMBER   PIC X(10).
                    07  PGET-INSURANCE-NAME PIC X(10).
                    07  PGET-PROVIDER-NUMBER    PIC X(10).
                    07  PGET-RECIPIENT-NUMBER   PIC X(20).
                    07  PGET-INSURANCE-START-DATE   PIC X(10).
                    07  PGET-INSURANCE-END-DATE PIC X(10).

