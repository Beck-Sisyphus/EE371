/*! taxCalculator.c
 *
 * The tax calculator takes in user input of salary and specific state
 * income tax to calculate the amount of salary that goes to social security,
 * federal income tax, state tax, and net income.
 *
 * Raymond W. Mui , AJ Townsend, Beck Pang
 */
#include <stdio.h>
#include <stdint.h>
#include <ctype.h>

int toupper(int c);
int isalpha(int c);
int isdigit(int c);
int ispunct(int c);
void newline();

 int main(void){
 	double incomeB4Tax = 0;
 	char ansStateTax = '\0';
 	double stateTaxRate = 0; //request tax rate as a percentage
 	double stateTax = 0;
 	// 10.3 % of first 65000 must be put into Social Security before taxes
 	double socialSecurityReq = 65000;
 	double socialSecurityRate = .103;
 	double cost2SS = 0; //social security cost
 	double TaxBrackReq = 30000;
 	double fedTaxRate = .28;
 	double fedTaxMin = 3500;
 	double fedTax = 0;
	double totalTax = 0;
 	double netIncome = 0;

 	//intro
 	printf("Welcome to the Tax Calculator !\n"); 
 	printf("Congratulations on your job offer!\n");
 	printf("I am here to ensure that you file your taxes correctly based off of your salary offer.\n");
 	newline();
 	
 	// prompt for salary offer
 	printf("Please enter your salary offer (enter numerical value): \n");
 	scanf("%lf",&incomeB4Tax);
 	getchar(); //clear buffer
	
 
 	//prompt to see if state has income tax or not
	printf("Does your state you plan to work in have state income tax (Y or N)? \n");
	scanf("%c", &ansStateTax);
	getchar();
	
 
	// if yes , ask for state tax rate
	while((toupper(ansStateTax) == 'Y' || toupper(ansStateTax)!= 'N')&&(toupper(ansStateTax) != 'Y' || toupper(ansStateTax) == 'N')) {
		printf("Input value invalid, please input a Y or N. \n");
		scanf("%c",&ansStateTax);
		getchar();
	}

	// if yes, ask for state tax rate
 	if(toupper(ansStateTax) == 'Y') {
		printf("Please enter your state tax rate (decimal value): \n");
 		scanf("%lf", &stateTaxRate);
		getchar();
 		while ((stateTaxRate >= 1) | (isalpha(stateTaxRate) | ispunct(stateTaxRate))) {
 			printf("Please enter state tax rate as a decimal value:\n");
 			scanf("%lf", &stateTaxRate);
 			getchar();
 		}	
 	}

 	// checks social security requirements
 	if (incomeB4Tax < socialSecurityReq) {
 		cost2SS = incomeB4Tax * socialSecurityRate;
	} else{
 		cost2SS = (socialSecurityReq * socialSecurityRate);
 	}
	newline();
 	printf("$%.2f of your salary goes to Social Security.\n",cost2SS);

 	// federal tax calculation
 	if (incomeB4Tax < TaxBrackReq) {
 		fedTax = fedTaxMin;
 	}else {
 		fedTax = fedTaxMin + ((incomeB4Tax - TaxBrackReq) * fedTaxRate);
 	}
 	printf("You will need to pay $%.2f towards federal income tax.\n",fedTax);
 	
 	stateTax = incomeB4Tax * stateTaxRate;
 	printf("You will need to pay $%.2f towards state income tax.\n", stateTax);

	totalTax = stateTax + fedTax;
	printf("Total payment towards tax:$%.2f\n",totalTax);
 	netIncome = incomeB4Tax -fedTax - stateTax - cost2SS;
	if(netIncome <= 0 ) {
		printf("You have lost $%.2f this year.\n",netIncome);
	}else {
 		printf("Your net income after tax is : $%.2f. \n",netIncome);
 	}
	return 0;
 }

 void newline() {
 	printf("\n");
 }
