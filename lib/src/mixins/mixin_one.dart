
class TheSuperClass{
  //This is the super class of our Mixins tree
}


//1- I can use all properties and methods of TheSuperClass with GeneralClass
//2- Mixin class must be "on" the super class
//3- I can NOT use any Mixin class with GeneralClass if the super class not
// implemented on the extended TheSuperClass

class GeneralClass extends TheSuperClass with MixinOne,MixinTwo{
 //
}

class FirstClass {

  GeneralClass? generalClass;

  FirstClass(){
    generalClass = GeneralClass();
  }

  int? processOneValue;
  int? processOne(){
    //
    processOneValue = generalClass!.showNumbersMethod();
    return processOneValue;
  }

  int? processTwoValue ;
  int? processTwo(int? selectValue){
    processTwoValue = generalClass!.showResultNumber(selectValue);
    return processTwoValue;
  }
}


mixin MixinOne on TheSuperClass {
  int? selectedNumber = 0;

  //MixinOne();   // Mixin can't declare a constructor

  int? showNumbersMethod() {
    selectedNumber = 10;
    return selectedNumber;
  }
}

mixin MixinTwo on TheSuperClass{

  int? resultNumber;

  int? showResultNumber(int? insertedNum) {
    resultNumber = 5 + insertedNum!;
    return resultNumber;
  }
}

mixin MixinThree on TheSuperClass{
  List? resultList;
  Future<List?>? getResultList(String? email,String? password)async{
    resultList = await DatabaseList().resultListData(email,password);
    return resultList;
  }
}

class DatabaseList{

  String? emailValue;
  String? passwordValue;
  List? returnedListFuture;

  Future<List?>? resultListData(String? emailVal,String? passwordVal) async{
    return returnedListFuture;
  }
}



