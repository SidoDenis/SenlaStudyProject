public class Printer {
    string textToPrint;
    
    public Printer(string text){
        textToPrint = text;
    }
    
    public string equalsMethod(string text){
        if(textToPrint.equals(text)){
            return ('YES');
        }
        else return ('NO');
    }
    
    public Integer hashCode(){
        return textToPrint.hashCode();
    }
}