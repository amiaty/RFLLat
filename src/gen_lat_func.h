#ifndef GEN_LAT_FUNC_H_
#define GEN_LAT_FUNC_H_


/*************************************************************************/
/*************************************************************************/
//GENERAL FUNCTIONS.
/*************************************************************************/
/*************************************************************************/

/*************************************************************************/
//Copies matrix A to matrix B.
//Arguments:
//pA - Pointer to matrix A.
//pB - Pointer to matrix B.
//nel - Total number of elements.
/*************************************************************************/
void CopyAtoB(double* pA, double* pB, int nel);

/*************************************************************************/
//For a matrix of reals, returns the column sums of the squared values.
//Arguments:
//pmat - Pointer to a matrix.
//pmatSqCS - Pointer to the array of column sums.
//nr - Number of rows of matrix.
//nc - Number of cols of matrix.
/*************************************************************************/
void SqColSums(double* pmat, double* pmatSqCS, int nr, int nc);

/*************************************************************************/
//For a matrix of reals, returns the row sums of the squared values.
//Arguments:
//pmat - Pointer to a matrix.
//pmatSqRS - Pointer to the array of row sums.
//nr - Number of rows of matrix.
//nc - Number of cols of matrix.
/*************************************************************************/
void SqRowSums(double* pmat, double* pmatSqRS, int nr, int nc);

/*************************************************************************/
//For a matrix of reals, and returns the total sum of the squared values.
//Arguments:
//pmat - Pointer to a matrix.
//nel - Total number of elements.
/*************************************************************************/
double SqTotSum(double* pmat, int nel);

/*************************************************************************/
//Takes pointers to two matrices, poldMat and pnewMat, and calculates the
//square root of the Frobeniuus norm of the difference divided by the
//square root of the Frobenius norm of oldMat.
//Arguments:
//pnewMat - Pointer to the new matrix.
//poldMat - Pointer to the old matrix.
//nel - Total number of elements.
//thresh - The threshold for convergence.  If oldMat=0 and newMat=0,
//function returns 0.  If only oldMat=0, function returns thresh+1.
/*************************************************************************/
double MatErr(double* pnewMat, double* poldMat, int nel, double thresh);

/*************************************************************************/
//Soft threshholds val by thresh.
//Arguments:
//val - What we want to soft threshold.
//thresh - Thet value by which we are soft thresholding.
/*************************************************************************/
double SoftThresh(double val, double thresh);


/*************************************************************************/
/*************************************************************************/
//FUNCTIONS SPECIFIC TO LATENT FEATURE MODEL.
/*************************************************************************/
/*************************************************************************/

/*************************************************************************/
//Creates the the vector of \tilde{Y}_j.
//Arguments:
//pnewY - Poimter to array of \tilde{Y}_j.
//pY - Pointer to the original data matrix.
//pB - Pointer to the current Beta matrix.
//pnewT - Pointer to the current Theta matrix, to be updated.
//j - The current row index of Theta.
//S - Number of columns of Y.
//L - Number of rows of Y.
//J - Number of columns of Beta.
/*************************************************************************/
void MakeTldY(double* ptldY, double* pY, double* pB, double* pnewT,
	      int j, int S, int L, int J);

void MakeTldY2(double* ptldY, double* pY, double* pA, double* pB,
               double* pnewT, int j, int S, int L, int J);
/*************************************************************************/
//Creates the the vector of \grave{Y}_j.
//Arguments:
//pgrvY - Poimter to array of \grave{Y}_j.
//pY - Pointer to the original data matrix.
//pT - Pointer to the current Theta matrix.
//pnewB - Pointer to the current Beta matrix, to be updated.
//pTSqRS - Pointer to the array of row sums of Theta^2.
//j - The current row index of Theta.
//S - Number of columns of Y.
//L - Number of rows of Y.
//J - Number of columns of Beta.
/*************************************************************************/
void MakeGrvY(double* pgrvY, double* pY, double* pT, double* pnewB,
	      double* pTSqRS, int j, int S, int L, int J);

/*************************************************************************/
//Calculates \sum_{k\ne j}\beta_{lk}\theta_{ks}.
//Arguments:
//pB - Pointer to Beta.
//pT - Pointer to Theta.
//s - Column of Theta.
//l - Row of Beta.
//j - Row of Theta (or column of Beta) not included in sum.
//S - Number of columns of Y.
//L - Number of rows of Y.
//J - Number of columns of Beta.
/*************************************************************************/
double BTljsSum(double* pB, double* pT, int s, int l, int j, int S, int L,
		int J);

/*************************************************************************/
//Estimates the value of the Beta matrix for a given Theta matrix.
//Arguments:
//pnewB - The current Beta which will become updated.
//pY - Pointer to the data matrix.
//pT - Pointer to the current Theta matrix.
//rlam1 - Lambda_1.
//rlam2 - Lambda_2.
//rthresh - The error threshold for determining convergence.
//imaxiter - The maximum number of iterations.
//S - Number of samples.
//L - Number of chromosomal locations.
//J - Number of latent features.
/*************************************************************************/
void BC(double* pnewB, double* pY, double* pT, double rlam1, double rlam2,
	double rthresh, int imaxiter, int S, int L, int J);
// BC2 is same as BC plus new matrix pA as an input
void BC2(double* pnewB, double* pY, double* pA, double* pT, double rlam1, double rlam2,
        double rthresh, int imaxiter, int S, int L, int J);
/************************************************************************/
//Updates Beta.
//Arguments:
//pnewB - Pointer to the current Beta which will be updated.
//pY - Pointer to the original data matrix.
//pT - Pointer to the current Theta matrix.
//pTSqRS - A pointer to the array of row sums of Theta^2.
//rlam1 - Lambda_1.
//rlam2 - Lambda_2.
//S - Number of samples.
//L - Number of chromosomal locations.
//J - Number of latent features.
/************************************************************************/
void UpdateBC(double* pnewB, double* pY, double* pT, double* pTSqRS,
	      double rlam1, double rlam2, int S, int L, int J);
// UpdateBC2 is same as UpdateBC plus new matrix pA as an input
void UpdateBC2(double* pnewB, double* pY, double* pA, double* pT, double* pTSqRS,
              double rlam1, double rlam2, int S, int L, int J);
/***********************************************************************/
//Estimates the value of the Theta matrix for a given Beta matrix and
//returns the number of iterations.
//Arguments:
//pnewT - The current Theta which will be updated.
//pY - The data matrix.
//pB - The current Beta matrix.
//rthresh - The error threshold for determining convergence.
//imaxiter - The maximum number of iterations.
//rsT -  The constraint on the L2 sum of each row of Theta.
//S - Number of samples.
//L - Number of chromosomal locations.
//J - Number of latent features.
/***********************************************************************/
int TLatL2C(double* pnewT, double* pY, double* pB, double rthresh,
	     int imaxiter, double rsT, int S, int L, int J);
// TLatL2C2 is same as TLatL2C plus new matrix pA as an input
int TLatL2C2(double* pnewT, double* pY, double* pA, double* pB, double rthresh,
            int imaxiter, double rsT, int S, int L, int J);
/***********************************************************************/
//Updates Theta.
//Arguments:
//pnewT - The matrix which will become the updated Theta.
//pY - Pointer to the original data matrix.
//pB - Pointer to the current Beta matrix.
//pBSqCS - A pointer to the array of column sums of Beta^2.
//rsT - The constraint on the L2 sum of each row of Theta.
//S - Number of samples.
//L - Number of chromosomal locations.
//J - Number of latent features.
/***********************************************************************/
void UpdateTLatL2C(double* pnewT, double* pY, double* pB,
		   double* pBSqCS, double rsT, int S, int L, int J);

void UpdateTLatL2C2(double* pnewT, double* pY, double* pA, double* pB,
                   double* pBSqCS, double rsT, int S, int L, int J);
/************************************************************************/
//Calculates the residual sum of squares .
//Arguments:
//pY - Pointer to the original data matrix.
//pB - Pointer to the current Beta matrix.
//pT - Pointer to the current Theta matrix.
//S - Number of samples.
//L - Number of chromosomal locations.
//J - Number of latent features.
/************************************************************************/
double LatRSS(double* pY, double* pB, double* pT, int S, int L, int J);

/************************************************************************/
//Calculates the BIC.
//Arguments:
//rss - The residual sum of squares.
//pB - Pointer to the current Beta matrix.
//S - Number of samples.
//L - Number of chromosomal locations.
//J - Number of latent features.
/************************************************************************/
double LatBIC(double rss, double* pB, int S, int L, int J);

/*************************************************************************/
/*************************************************************************/
//FUNCTIONS SPECIFIC TO Half-Quadratic Method.
/*************************************************************************/
/*************************************************************************/

/************************************************************************/
//Calculates the additive form of Welsch function.
//Arguments:
//pB - Pointer to the current A matrix.
//S - Number of samples.
//L - Number of chromosomal locations.
//sigma - parameter of the welsch function, default is 0.5
/************************************************************************/
void UpdateWelsch(double* pA, int S, int L, double sigma = 0.5);

/************************************************************************/
//Calculates the additive form of Welsch function.
//Arguments:
//pB - Pointer to the current A matrix.
//S - Number of samples.
//L - Number of chromosomal locations.
//sigma - parameter of the welsch function, default is 0.1
/************************************************************************/
void UpdateHuber(double* pA, int S, int L, double lambda = 0.1);

/************************************************************************/
//Calculates Res = Y - B*T.
//Arguments:
//pRes - Pointer to the current A matrix.
//S - Number of samples.
//L - Number of chromosomal locations.
//J - Number of latent features.
/************************************************************************/
void ComputeY_BT(double* pRes, double* pY, double* pB, double* pT,
                 int L, int J, int S);

/************************************************************************/
//Update the sigma before runing Welsch.
//Arguments:
//pQ - Pointer to the current (Y - BT) matrix.
//S - Number of samples.
//L - Number of chromosomal locations.
//sigma - output
/************************************************************************/
double UpdateSigma(double* pQ, int S, int L, double dmul = 2.0);

/************************************************************************/
//Update the lambda before runing Huber.
//lambda will be adaptive in this way.
//Arguments:
//pQ - Pointer to the current (Y - BT) matrix.
//S - Number of samples.
//L - Number of chromosomal locations.
//lambda - output
// lambda new = alpha * median(|*pQ|)
/************************************************************************/
double UpdateLambda(double* pQ, int S, int L, double alpha = 0.8);
#endif
