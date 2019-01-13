#!/bin/bash
#Αρχικοποίηση των μεταβλητών σε NULL
#έτσι ώστε να γίνει ο έλεγχος απο το If BLOCK αργότερα
file=''
id=''
firstName=''
lastName=''
bsince=''
buntil=''
eid=''
ecolumn=''
evalue=''
socialmedia=""
#Με χρήση των cases και της shift μέσα σε while οι μεταβλητές
#παίρνου τις τίμες του απο τα ορίσματα που δίνονται στην εντολή
while [ $# -ne 0 ]
 do
  case $1 in
     -f)
    file=$2
    ;;
  esac
  case $1 in
    -id)
    id=$2
    ;;
  esac
  case $1 in
    --firstnames)
    firstName='exist'
    ;;
  esac
  case $1 in
    --lastnames)
    lastName='exist'
    ;;
  esac
  case $1 in
    --born-since)
    bsince=$2
    ;;
  esac
  case $1 in
    --born-until)
    buntil=$2
    ;;
  esac
  case $1 in
    --edit)
    eid=$2
    ecolumn=$3
    evalue=$4
    ;;
  esac
  case $1 in
    --socialmedia)
    socialmedia='exist'
    ;;
  esac
  shift
done
#ερώτημα 1: εκτυπώννται τα ΑΜ
if [ -z "$file" ] # ελέγχεται αν υπήρχε αρχείο στο όρισμα με το -z(έλεγχος αν η μεταβλητή είναι null)
  then
      echo "1054410-1054319"
#ερώτημα 3: αν τα --firstnames ή --lastnames υπήρχαν στην εντολή τότε
# στο while οι μεταβλητές firstName και lastName πήραν την τιμή exist στο while
# και με την βοήθεια του ελέγχου -n ελέγχεται αν η μεταβλητή δεν είναι null
elif [ -n "$firstName" ]
  then
      grep "^[^#;]" $file | awk -F '|' '{print $2}' | sort | uniq #με το grep αφαιρέσαμε τα σχολια και με το awk απομωνόσαμε την στήλη με ονόματα
      shift                                                       #με το sort ταξινομήθηκαν αλφαβητικα και με το uniq αφαιρέθηκαν τα διπλότυπα
elif [ -n "$lastName" ]
  then
      grep "^[^#;]" $file | awk -F '|' '{print $3}' | sort | uniq #ενώ εδώ απομονώσαμε την στήλη με τα επώνυμα και με τα sort και uniq
      shift                                                       #ταξινομήθηκαν αλφαβητικά και αφαιρέθηκαν τα διπλότυπα
#ερώτημα 4: εκτύπωση όσων εγγραφών έχουν ημερομηνία γέννησης μέσα σε ένα καθορισμένο διάστημα
elif [ -n "$bsince" ] && [ -z "$buntil" ] #έλεγχος για το αν υπάρχει μόνο το --born-since και όχι --born-until με τα -n και -z αντίστοιχα
  then
      awk -F '|' -v from="$bsince" '{if (FNR>1 && from<=$5){print}}' $file | sort  #με χρήση του awk εκτυπώνονται μόνο οι σειρές που ικανοποιούν την συνθήκη
      shift                                                                        #και ταξινομούνται με το sort
elif [ -n "$buntil" ] && [ -z "$bsince" ] #έλεγχος για το αν υπάρχει μόνο το --born-until και όχι το --born-until με τα -n και -z αντίστοιχα
  then
      awk -F '|' -v until="$buntil" '{if (FNR>1 && until>=$5){print}}' $file | sort #με χρήση του awk εκτυπώνονται μόνο οι σειρές που ικανοποιούν την συνθήκη
      shift                                                                         #και ταξινομούνται με το sort
elif [ -n "$buntil" ] && [ -n "$bsince" ] #έλεγχος για το αν υπάρχουν ταυτόχρονα τα --born-until και --born-until με τα -n και -n αντίστοιχα
  then
      awk -F '|' -v from="$bsince" -v until="$buntil" '{if (FNR>1 && from<=$5 && until>=$5){print}}' $file | sort #με χρήση του awk εκτυπώνονται μόνο οι σειρές
      shift                                                                                                       #που ικανοποιούν την συνθήκη και ταξινομούνται με το sort
#ερώτημα 1: έλεγχος αν υπήρχαν οποιαδήποτε άλλα ορίσματα εκτός απο το όνομα του αρχείου αν όχι τότε εκτυπώνεται το αρχείο χωρίς τα σχόλια
elif [ -z "$id" ] && [ -z "$firstName" ] && [ -z "$lastName" ] && [ -z "$bsince" ] && [ -z "$buntil" ] && [ -z "$eid" ] && [ -z "$ecolumn" ] && [ -z "$evalue" ] && [ -z "$socialmedia" ]
then
      grep "^[^#;]" $file #αφαιρούνται οποιεσδήποτε γραμμές με σχόλια και εκτυπώνεται το αρχείο
      shift
#ερώτημα 2: έλεγχος αν υπήρχαν οποιαδήποτε άλλα ορίσματα εκτός απο το όνομα του αρχείου και το id της ζητούμενης εγγραφησ αν όχι τότε εκτυπώνεται το ονοματεπώνυμο και η ημερομηνια γέννησης
elif [ -z "$firstName" ] && [ -z "$lastName" ] && [ -z "$bsince" ] && [ -z "$buntil" ] && [ -z "$eid" ] && [ -z "$ecolumn" ] && [ -z "$evalue" ] && [ -z "$socialmedia" ]
  then
      grep "$id" $file | awk -F '|' '{print $2,$3,$5}' #το grep απομωνόνει την σωστή γραμμή βάση του id και το awk τυπώνει τις σωστές στήλες
      shift
#ερώτημα 5: αν υπήρχαν στην εντολή τα ορίσμαρα --edit και id value column τότε οι μεταβλητές eid ecolumn evalue πήραν τιμές
elif [ -n "$eid" ] && [ -n "$ecolumn" ] && [ -n "$evalue" ] #έλεγχος αν οι μεταβλητές eid ecolumn evalue πήραν τιμές
 then
   cp "$file" "temp_file.dat" #δημιουργούμε ένα προσωρινό αρχείο σε περίπτωση λάθους στην εντολή
   cat "temp_file.dat" | awk -v id=$eid -v column=$ecolumn -v value=$evalue '
   BEGIN {FS="|";OFS="|"}; $1==id && column>=2 && column<=9 {$column=value;}; {print $0};
   ' > "$file" #με το cat οδηγούμε το προσωρινό αρχείο στο awk και με αυτό ελέγχουμε αν υπάρχει το id και αν ζητέιται να αλλάξει κάποια στήλε εκτός της πρώτης που έχει τα id
   rm "temp_file.dat"; #αν συμβαίνουν όλα αυτά τότε αλλάζει η τίμή στη στήλη που ζητήσαμε με την τιμή που δώσαμε και αποθηκεύεται το αποτέλεσμα στο αρχείο
   shift #τέλος διαγράφουμε το προσωρινό αρχείο
#ερώτημα 5: αν υπήρχει στην εντολή το όρισμα --socialmedia τότε στο while η μεταβλητή πήρε την τιμή exist και θα τυπωθούν τα socialmedia και ο αριθμός των χρηστών τους για το καθένα
elif [ -n "$socialmedia" ]#έλεγχος της μετταβλητής socialmedia με χρήση του -n
 then
  grep "^[^#;]" $file | awk -F '|' '{print $9}' | sort | uniq -c #το grep αφειρεί τις γραμμές τών σχολίων και έπειτα το awk απομονώνει την στήλη με τα socialmedia
  shift                                                          #έπειτα με το sort ταξινομούνται αλφαβητικά και με το uniq -c υπολογίζεται το αθροισμα για κάθε ένα απο τα socialmedia 
fi
