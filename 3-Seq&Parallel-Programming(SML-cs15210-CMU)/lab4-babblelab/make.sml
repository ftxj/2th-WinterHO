CM.make "support/support.cm";
CM.make "sources.cm";
Tester.testChoose();
Tester.testKGramStats();
print ("I got ::"^Tester.babbleFromFile "data/shakespeare.txt");