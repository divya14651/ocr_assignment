class LuhnService {

  static bool isValid(String number){

    number =
        number.replaceAll(" ", "");

    int sum = 0;

    bool alternate = false;

    for(int i = number.length - 1;
    i >= 0;
    i--){

      int n = int.parse(number[i]);

      if(alternate){

        n *= 2;

        if(n > 9){
          n -= 9;
        }
      }

      sum += n;

      alternate = !alternate;
    }

    return sum % 10 == 0;
  }
}