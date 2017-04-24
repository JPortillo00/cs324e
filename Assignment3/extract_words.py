Unique_Words = []

def char_check(string):
    word = ""
    for x in string:
        if ( 'a' <= x and x <= 'z'):
            word += x
    return word     

def AllWords(f_in,f_out):
    for line in f_in:        
        text = line.split()                
        for i in text:
            i = char_check(i.lower().rstrip().lstrip())
            if not i == "":
                f_out.write(i + '\n')         
            if (not (i in Unique_Words)):
                if not i == "":
                    Unique_Words.append(i.lower())           
        
            
def UniqueWords(f_out):
    for i in Unique_Words:
        f_out.write(i + '\n')

def WordFreq(f_out):   
    frequencies = {}
    file = open("allwords.txt",'r')
    for word in file:
        word = word[:-1]
        if word in frequencies.keys():
            frequencies[word] += 1
        else:
            frequencies[word] = 1
    uniquefreq = open("uniquefrquency.txt",'w')
    for word in frequencies.keys():
        uniquefreq.write(word + ": " + str(frequencies[word]) + "\n")      
            
    countfrequencies = {}
    for word in frequencies.keys():
        if frequencies[word] in countfrequencies.keys():
            countfrequencies[frequencies[word]] += 1
        else:
            countfrequencies[frequencies[word]] = 1
    for count in sorted(countfrequencies.keys()):
        f_out.write(str(count) + ":" + str(countfrequencies[count]) + "\n")
       



def main():
    f = open("PRIDE_PREJUDICE.txt",'r')
    allwords = open("allwords.txt",'w')
    uniquewords = open("uniquewords.txt",'w')
    wordfreq = open("wordfrequency.txt",'w')
    AllWords(f,allwords)
    UniqueWords(uniquewords)
    WordFreq(wordfreq)
    
main()
