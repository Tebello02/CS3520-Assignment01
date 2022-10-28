//==============================================================
//Author: Tebello Sephofane
//Purpose: A program that prints first 10 reversible Prime squares
//Date:01-10-2022
//Contact:tsephofane@gmail.com
//==============================================================

#include <stdio.h>
#include <stdbool.h>
#include <math.h>

bool IsPrime(int n)
{
	
	if(n < 2) 
		return false;
	for(int i = 2;i < n;i++)
	{
		if(n % i == 0)
			return false;
	}
		return true;
}

int ReverseNum(int n)
{
	int reversed_num = 0,remainder;
	while(n != 0)
		{
			remainder = n % 10;
			reversed_num = reversed_num *10 + remainder;
			n /= 10;				
		}
	return reversed_num;	
}
double SquareRoot(int n)
{
	float x =0 ;
	double i;
	while (i < n)
	{
		x = x + 1;
		i = x*x;
		if(n == i)
		{
			return x;
			break;
		}
	}
}

bool IsSquareNum(int n)
{	
	double root;
	//root = sqrt(n);
	root = SquareRoot(n);
	if(n == (root*root))
		return true;
	else	return false;
}

bool IsPalindrome(int n)
{
	if(n == ReverseNum(n))
		return true;
	else
		return false;	
}
int PrintReversiblePrimes()
{
	int count = 1,num2,num3, index = 0;
	double root;
	for(int i = 1;i <= count; i++)
	{
		if(IsPrime(i))
		{
			num2 = i*i;  //square of prime number
		 	num3= ReverseNum(num2);
		 	bool set = false;
		 	if(IsSquareNum(num3) && !(IsPalindrome(num3)) && IsPrime(SquareRoot(num3)))
		 		set = 1;
		 		while((index < 10) && set)
		 		{
		 			printf("%d \n", num3);
					index++;
					set = 0; // reset	
				}				
		}
		count++;
		if (index == 10) return;
	}	
}

int main()
{
	PrintReversiblePrimes();
	return 0;
}