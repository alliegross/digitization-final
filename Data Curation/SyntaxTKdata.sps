* Encoding: UTF-8.

*This is opening the data from my local file. This does not apply for your local storage of the file.
GET DATA
  /TYPE=XLSX
  /FILE='/Users/megielkerkhoven/Downloads/stemming_all_2013_2016_new2.xlsx'
  /SHEET=name 'stemming_all_2013_2016_new2.txt'
  /CELLRANGE=FULL
  /READNAMES=ON
  /DATATYPEMIN PERCENTAGE=95.0.
EXECUTE.
DATASET NAME DataSet2 WINDOW=FRONT.
freq partij.

*creating a variable that is binary for pro if anybody in the party voted pro.
RECODE voor (0=0) (0.999 thru Highest=1) INTO voorbin.
EXECUTE.
descriptives voorbin.

*renaming the variable names to english.
Rename variables (datum=date) (maand=month) (soortstemming=voteType) (aanver=result) (voorbin=binPro)
(partij=party) (zetels=seats) (voor=pro) (tegen=against) (maxtegen=binAgainst) (onthouden=abstain) (afwijkend=divergent).
Execute.

*adding english variable labels that also show what the variable entails.
variable labels
doc 'document number' 
date 'date of the vote'
month 'month of the vote'
dossier 'dossier number'
type 'type of document that his voted on, either a motion (like an idea) or a proposal (a bill) or an amendment (a change to a proposal)'
voteType 'type of vote, either per person (hoofdelijk) or per party (handopsteken). Parliament votes procedurally by handopsteken as people are assumed to vote by party, if members want to vote per person, they request a per person vote (hoofdelijk) '
result 'result of the vote, either aangenomen (passed) or verworpen (rejected)'
party 'which party'
seats 'amount of parliamentarians that were eligible to vote at the time of vote'
pro 'amount of member that voted pro in that party'
against 'amount of member that voted against in that party'
binagainst 'did anybody in the party vote against? binary'
abstain 'amount of members that voted abstain in that party'
divergent 'did anybody in the party vote divergent from the rest? binary'
binpro 'did anybody in the party vote pro? binary'.
EXECUTE. 
freq party.

*making the file wide instead of long. 
*first we make separate variables of each party.

DO IF  (party = "50PLUS").
RECODE pro (ELSE=Copy) INTO pro50Plus.
RECODE against (ELSE=Copy) INTO against50Plus.
END IF.

DO IF  (party = "50PLUS/Baay-Timmerman").
RECODE pro (ELSE=Copy) INTO pro50PBaayTimmerman.
RECODE against (ELSE=Copy) INTO against50PBaayTimmerman.
END IF.


DO IF  (party = "50PLUS/Klein").
RECODE pro (ELSE=Copy) INTO pro50PKlein.
RECODE against (ELSE=Copy) INTO against50PKlein.
END IF.

DO IF  (party = "Bontes").
RECODE pro (ELSE=Copy) INTO proBontes.
RECODE against (ELSE=Copy) INTO againstBontes.
END IF.

DO IF  (party = "CDA").
RECODE pro (ELSE=Copy) INTO proCDA.
RECODE against (ELSE=Copy) INTO againstCDA.
END IF.

DO IF  (party = "CU").
RECODE pro (ELSE=Copy) INTO proCU.
RECODE against (ELSE=Copy) INTO againstCU.
END IF.

DO IF  (party = "D66").
RECODE pro (ELSE=Copy) INTO proD66.
RECODE against (ELSE=Copy) INTO againstD66.
END IF.

DO IF  (party = "GL").
RECODE pro (ELSE=Copy) INTO proGL.
RECODE against (ELSE=Copy) INTO againstGL.
END IF.

DO IF  (party = "GrK√ñ").
RECODE pro (ELSE=Copy) INTO proDenk.
RECODE against (ELSE=Copy) INTO againstDenk.
END IF.

DO IF  (party = "GrBvK").
RECODE pro (ELSE=Copy) INTO proGrBvK.
RECODE against (ELSE=Copy) INTO againstGrBvK.
END IF.

DO IF  (party = "Houwers").
RECODE pro (ELSE=Copy) INTO proHouwers.
RECODE against (ELSE=Copy) INTO againstHouwers.
END IF.

DO IF  (party = "Klein").
RECODE pro (ELSE=Copy) INTO pro50Klein.
RECODE against (ELSE=Copy) INTO againstKlein.
END IF.

DO IF  (party = "PvdA").
RECODE pro (ELSE=Copy) INTO proPvdA.
RECODE against (ELSE=Copy) INTO againstPvdA.
END IF.

DO IF  (party = "PvdD").
RECODE pro (ELSE=Copy) INTO proPvdD.
RECODE against (ELSE=Copy) INTO againstPvdD.
END IF.

DO IF  (party = "PVV").
RECODE pro (ELSE=Copy) INTO proPVV.
RECODE against (ELSE=Copy) INTO againstPVV.
END IF.

DO IF  (party = "SGP").
RECODE pro (ELSE=Copy) INTO proSGP.
RECODE against (ELSE=Copy) INTO againstSGP.
END IF.

DO IF  (party = "SP").
RECODE pro (ELSE=Copy) INTO proSP.
RECODE against (ELSE=Copy) INTO againstSP.
END IF.

DO IF  (party = "Van Klaveren").
RECODE pro (ELSE=Copy) INTO provK.
RECODE against (ELSE=Copy) INTO againstvK.
END IF.

DO IF  (party = "Van Vliet").
RECODE pro (ELSE=Copy) INTO provV.
RECODE against (ELSE=Copy) INTO againstvV.
END IF.

DO IF  (party = "VVD").
RECODE pro (ELSE=Copy) INTO proVVD.
RECODE against (ELSE=Copy) INTO againstVVD.
END IF.



*making binary party variables and then a "total party" variable with 1 = votedpro 2=votedboth 3 =votedagainst.

DO IF  (party = "50PLUS").
RECODE binpro (ELSE=Copy) INTO binpro50Plus.
RECODE binagainst (ELSE=Copy) INTO binagainst50Plus.
END IF.
IF (   binpro50plus =1)  st50plus  =1.
IF (   binagainst50plus =1)        st50plus =3.
IF (      binpro50plus=1) AND ( binagainst50plus   =1) st50plus  =2.


DO IF  (party = "50PLUS/Baay-Timmerman").
RECODE binpro (ELSE=Copy) INTO binpro50PBaayTimmerman.
RECODE binagainst (ELSE=Copy) INTO binagainst50PBaayTimmerman.
END IF.
IF (  pro50PBaayTimmerman  =1)   st50PBaayTimmerman =1.
IF (   against50PBaayTimmerman =1)      st50PBaayTimmerman   =3.
IF (     pro50PBaayTimmerman =1) AND (    against50PBaayTimmerman=1)  st50PBaayTimmerman =2.


DO IF  (party = "50PLUS/Klein").
RECODE binpro (ELSE=Copy) INTO binpro50PKlein.
RECODE binagainst (ELSE=Copy) INTO binagainst50PKlein.
END IF.
IF (  binpro50PKlein  =1)    st50PKlein=1.
IF (   binagainst50PKlein =1)     st50PKlein    =3.
IF (   binagainst50PKlein   =1) AND (  binpro50PKlein  =1) st50PKlein  =2.


DO IF  (party = "Bontes").
RECODE binpro (ELSE=Copy) INTO binproBontes.
RECODE binagainst (ELSE=Copy) INTO binagainstBontes.
END IF.
IF ( binproBontes   =1)   stBontes =1.
IF (   binagainstBontes =1)      stBontes   =3.
IF (  binproBontes    =1) AND (  binagainstBontes  =1)   stBontes=2.


DO IF  (party = "CDA").
RECODE binpro (ELSE=Copy) INTO binproCDA.
RECODE binagainst (ELSE=Copy) INTO binagainstCDA.
END IF.
IF (  binproCDA  =1)   stCDA =1.
IF (  binagainstCDA  =1)      stCDA   =3.
IF (    binproCDA  =1) AND (  binagainstCDA  =1) stCDA =2.


DO IF  (party = "CU").
RECODE binpro (ELSE=Copy) INTO binproCU.
RECODE binagainst (ELSE=Copy) INTO binagainstCU.
END IF.
IF (   binproCU =1)   stCU =1.
IF (  binagainstCU  =1)     stCU    =3.
IF (      binproCU=1) AND ( binagainstCU   =1)  stCU =2.


DO IF  (party = "D66").
RECODE binpro (ELSE=Copy) INTO binproD66.
RECODE binagainst (ELSE=Copy) INTO binagainstD66.
END IF.
IF (   binproD66 =1) stD66   =1.
IF (  binagainstD66  =1)    stD66     =3.
IF (     binproD66 =1) AND ( binagainstD66   =1) stD66   =2.

DO IF  (party = "GrK√ñ").
RECODE binpro (ELSE=Copy) INTO binproDenk.
RECODE binagainst (ELSE=Copy) INTO binagainstDenk.
END IF.
IF (  binproDenk  =1)  stDenk  =1.
IF (   binagainstDenk =1)      stDenk   =3.
IF (   binproDenk   =1) AND ( binagainstDenk   =1)  stDenk  =2.

DO IF  (party = "GL").
RECODE binpro (ELSE=Copy) INTO binproGL.
RECODE binagainst (ELSE=Copy) INTO binagainstGL.
END IF.
IF ( binproGL   =1)   stGL =1.
IF (   binagainstGL =1)    stGL     =3.
IF (    binproGL  =1) AND ( binagainstGL   =1)  stGL =2.


DO IF  (party = "GrBvK").
RECODE binpro (ELSE=Copy) INTO binproGrBvK.
RECODE binagainst (ELSE=Copy) INTO binagainstGrBvK.
END IF.
IF (  binproGrBvK  =1) stGrBvK   =1.
IF (  binagainstGrBvK  =1)     stGrBvK    =3.
IF (    binproGrBvK  =1) AND (  binagainstGrBvK  =1) stGrBvK   =2.


DO IF  (party = "Houwers").
RECODE binpro (ELSE=Copy) INTO binproHouwers.
RECODE binagainst (ELSE=Copy) INTO binagainstHouwers.
END IF.
IF (  binproHouwers  =1) stHouwers   =1.
IF ( binagainstHouwers   =1)     stHouwers    =3.
IF (   binproHouwers   =1) AND (   binagainstHouwers =1)  stHouwers =2.


DO IF  (party = "Klein").
RECODE binpro (ELSE=Copy) INTO binproKlein.
RECODE binagainst (ELSE=Copy) INTO binagainstKlein.
END IF.
IF (   binproKlein =1)  stKlein  =1.
IF (   binagainstKlein =1)     stKlein  =3.
IF (   binproKlein   =1) AND ( binagainstKlein   =1)   stKlein=2.


DO IF  (party = "PvdA").
RECODE binpro (ELSE=Copy) INTO binproPvdA.
RECODE binagainst (ELSE=Copy) INTO binagainstPvdA.
END IF.
IF (  binproPvdA  =1)  stPvdA  =1.
IF (  binagainstPvdA  =1)   stPvdA      =3.
IF (    binproPvdA  =1) AND (  binagainstPvdA  =1) stPvdA  =2.


DO IF  (party = "PvdD").
RECODE binpro (ELSE=Copy) INTO binproPvdD.
RECODE binagainst (ELSE=Copy) INTO binagainstPvdD.
END IF.
IF ( binproPvdD   =1)  stPvdD  =1.
IF (   binagainstPvdD =1)     stPvdD    =3.
IF (  binproPvdD    =1) AND (  binagainstPvdD  =1)  stPvdD =2.


DO IF  (party = "PVV").
RECODE binpro (ELSE=Copy) INTO binproPVV.
RECODE binagainst (ELSE=Copy) INTO binagainstPVV.
END IF.
IF (  binproPVV  =1)  stPVV  =1.
IF (   binagainstPVV =1)    stPVV     =3.
IF (    binproPVV  =1) AND (  binagainstPVV  =1) stPVV   =2.


DO IF  (party = "SGP").
RECODE binpro (ELSE=Copy) INTO binproSGP.
RECODE binagainst (ELSE=Copy) INTO binagainstSGP.
END IF.
IF (  binproSGP  =1)  stSGP  =1.
IF (   binagainstSGP =1)     stSGP    =3.
IF (    binproSGP  =1) AND ( binagainstSGP   =1) stSGP  =2.


DO IF  (party = "SP").
RECODE binpro (ELSE=Copy) INTO binproSP.
RECODE binagainst (ELSE=Copy) INTO binagainstSP.
END IF.
IF (   binproSP =1) stSP   =1.
IF (  binagainstSP  =1)     stSP    =3.
IF (   binproSP   =1) AND (   binagainstSP =1)  stSP =2.


DO IF  (party = "Van Klaveren").
RECODE binpro (ELSE=Copy) INTO binprovK.
RECODE binagainst (ELSE=Copy) INTO binagainstvK.
END IF.
IF (  binprovK  =1)   stvK =1.
IF (   binagainstvK =1)     stvK    =3.
IF (     binagainstvK =1) AND (  binprovK  =1) stvK  =2.


DO IF  (party = "Van Vliet").
RECODE binpro (ELSE=Copy) INTO binprovV.
RECODE binagainst (ELSE=Copy) INTO binagainstvV.
END IF.
IF (   binprovV =1)  stvV  =1.
IF (  binagainstvV  =1)   stvV      =3.
IF (    binagainstvV  =1) AND ( binprovV  =1) stvV  =2.


DO IF  (party = "VVD").
RECODE binpro (ELSE=Copy) INTO binproVVD.
RECODE binagainst (ELSE=Copy) INTO binagainstVVD.
END IF.
IF (  binprovvd=1)   stvvd=1.
IF (  binagainstvvd=1)          stvvd=3.
IF (binagainstvvd=1) AND (binprovvd) stvvd=2.

EXECUTE.
freq st50plus binpro50plus binagainst50plus binagainstvvd binprovvd stvvd.


*MAKING THE DATASET WIDE I.O. VERTICAL         I.E. MAKING ONE VOTE = ONE CASE WITH PARTIES AS VARIABLES.
DELETE VARIABLES month party pro against binagainst abstain binpro seats divergent.
SORT CASES BY dossier.
CASESTOVARS
  /ID=dossier
  /GROUPBY=INDEX.

*exporting the curated & restructured file to excell.
SAVE TRANSLATE OUTFILE='/Users/megielkerkhoven/Documents/VU/18:19/Digitisation/allvotesrestructured.xlsx'
  /TYPE=XLS
  /VERSION=12
  /MAP
  /FIELDNAMES VALUE=NAMES
  /CELLS=VALUES.


CORRELATIONS
  /VARIABLES=st50plus stCDA stCU stD66 stDenk stGL  
      stPvdA stPvdD stPVV stSGP stSP   stvvd
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.




