        02  APPOINTMOD.
            03  APNT-REQUEST.
              04  APNT-ARGUMENTS.
                05  APNT-CLASS         PIC X(2).
              04  APNT-METHOD          PIC X(100).
              04  APNT-CONTENT-TYPE    PIC X(100).
              04  APNT-CONTENT-LENGTH  PIC X(100).
              04  APNT-BODY            PIC X(1024).
            03  APNT-RESPONSE.
              04  APNT-INFORMATION-DATE   PIC X(8).
              04  APNT-INFORMATION-TIME   PIC X(6).
              04  APNT-API-RESULT      PIC X(2).
              04  APNT-API-RESULT-MSG  PIC X(100).
              04  APNT-RESKEY          PIC X(100).
              04  APNT-APPOINT-DATE     PIC X(8).
              04  APNT-APPOINT-TIME     PIC X(4).
              04  APNT-APPOINT-ID       PIC X(5).
              04  APNT-APPOINT-DEP-CODE  PIC X(2).
              04  APNT-APPOINT-DR-CODE  PIC X(5).
              04  APNT-APPOINT-MEMO     PIC X(100).
              04  APNT-PATIENT-INFOMATION.
                05  APNT-PATIENTID     PIC X(20).
                05  APNT-NAME          PIC X(100).
                05  APNT-KANANAME      PIC X(100).
                05  APNT-BIRTHDAY      PIC X(8).
                05  APNT-SEX           PIC X(1).
                05  APNT-ADDRESS-INFO.
                  06  APNT-HOME-ZIP-CODE  PIC X(7).
                  06  APNT-HOME-ADDRESSES PIC X(100).
                05  APNT-INSURANCE-INFO     OCCURS  4 TIMES.
                  06  APNT-MAIN-INSURANCE-CLASS   PIC X(10).
                  06  APNT-MAIN-INSURANCE-NUMBER  PIC X(10).
                  06  APNT-MAIN-INSURANCE-NAME    PIC X(10).
                  06  APNT-MAIN-MARK   PIC X(80).
                  06  APNT-MAIN-NUMBER PIC X(80).
                  06  APNT-MAIN-CONTINUATION  PIC X(10).
                  06  APNT-MAIN-ASSISTANCE    PIC X(10).
                  06  APNT-MAIN-FAMILY PIC X(10).
                  06  APNT-MAIN-POLICYHOLDER  PIC X(100).
                  06  APNT-MAIN-START-DATE    PIC X(10).
                  06  APNT-MAIN-END-DATE  PIC X(10).
                  06  APNT-PUBLIC-INSURANCE-INFO      OCCURS  3 TIMES.
                    07  APNT-INSURANCE-NUMBER   PIC X(10).
                    07  APNT-INSURANCE-NAME     PIC X(10).
                    07  APNT-PROVIDER-NUMBER    PIC X(10).
                    07  APNT-RECIPIENT-NUMBER   PIC X(10).
                    07  APNT-INSURANCE-START-DATE   PIC X(10).
                    07  APNT-INSURANCE-END-DATE PIC X(10).
