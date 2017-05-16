#include <iostream>

using namespace std;

int main()
{

    char inputName[126];

    cout <<("Give the name that you want to convert to ASCII code: \a");

    cin >> inputName;
    char *p = inputName;

    while ( *p != '\0')
    {
        cout<< (int)*p << "-";  //typecasting so char is converted to int.
        p++;
    }
    return 0;
}

