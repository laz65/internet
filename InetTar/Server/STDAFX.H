// stdafx.h : include file for standard system include files,
//  or project specific include files that are used frequently, but
//      are changed infrequently
//

#if !defined(AFX_STDAFX_H__78696A72_83ED_11D4_945E_0050044D962D__INCLUDED_)
#define AFX_STDAFX_H__78696A72_83ED_11D4_945E_0050044D962D__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#define _CRT_SECURE_NO_WARNINGS

#define VC_EXTRALEAN            // Exclude rarely-used stuff from Windows headers

#include <afxwin.h>         // MFC core and standard components
#include <afxext.h>         // MFC extensions
#include <afxdisp.h>        // MFC Automation classes
#include <afxdtctl.h>           // MFC support for Internet Explorer 4 Common Controls
#include <afxtempl.h>
#ifndef _AFX_NO_AFXCMN_SUPPORT
#include <afxcmn.h>                     // MFC support for Windows Common Controls
#endif // _AFX_NO_AFXCMN_SUPPORT
#include "TipDlg.h"
#include "MD5.h"
#include <afxdao.h>
#include <afxdisp.h>
#include <list>
#include <iostream>
#include <math.h>
#include <vector>
#include <afxdhtml.h>
// ������ �������������� �� ���������� ������� DAO
#pragma warning(disable : 4995)
// ������ �������������� �� ���������� ��������
#pragma warning(disable : 4996)
// ���� ��������� - ���������� ��������� �� � ������
//#define _LOG_ITAR
//������������ �-�� ������� �������
#define MAX_WORKSTATION	100
// ������������ ����������
struct _UInfo
{
char Fio[50];
DWORD Type, Admin;
bool Active;
unsigned char Hash[16];
char Creator[50];
};

typedef struct Dopusl
{
	int nomusl;
	char name[40];
	float tarif;
	int rf_code;
	char rf_name[20];
	int rf_rate;
	int tar_type;
} hDopusl;

typedef struct Setup
{
	char INomer[200]; //��� ����
	char IName[200]; // ������������ ����
	char Lock[200];  // ������� ��� ����������
	char UnLock[200];  // ������� ��� �������������
	//
	int nDopList; // �-�� ���.����� � ����� usl.ini
	//
	bool UseCassa;  // �������� �������� ���
	bool UseRF2160; // true - �������� ��� �� ��, false - �� �������
	bool UseBoth;  // ������ ���������� ����
	char PathBill [200]; //���� ����������� ����� ����� ��������� ��������
	//
	int CountComp; // �-�� ������� �������
	char CompName    [MAX_WORKSTATION] [70]; // ������ ���� ������� �������
	bool bActiv	[MAX_WORKSTATION]; // true - ������� �������� ����� ������������, false - ��� (���������, ����������)
	bool BlockInet; // ����������� ��������
	bool CloseExplorer; // ����������� ���������
	char GateWayName [200]; // IP Gateway
	bool Pipe; // ������� ������������� Pipes, ����� - Socket
	// ������ ������ �� ��������
	double Tarif1;  //Internet ������� 8-21
	double Tarif2;  //Computer ������� 8-21
	//
	double Tarif3;  //Internet �������� 21-8
	double Tarif4;  //Computer �������� 21-8
	//
	double Tarif5;  //Internet �����������
	double Tarif6;  //Computer �����������
	//
	double Tarif7;  //Student Internet �������
	double Tarif8;  //Student Internet �����������
	//
	char SharePath [200]; // ���� � ����� �����
	char PathName [200]; // ���� � ���������� � ���������� (����������� ���������.)
//!!! ��� ��������� ��� 
	double CurNds; // ������� ���
	//
	MD5_CTX m_md5;
} hSetup;

typedef struct OldSetup
{
/*
	int CountComPort; // �-�� ���-������ �� ��������� ���
	int CountComp;
	bool UseBoth;  // ������ ���������� ����
	CList <hDopusl, hDopusl&> *DopList;
	int nDopList;
	bool UseCassa;  // �������� �������� ���
	bool UseRF2160; // true - �������� ��� �� ��, false - �� �������
	char CassComPort[5];
	char PathBill [200];
	char IName[200];
	char INomer[200];
	char  CompComPort[50] [6]; //
	char  CompComPortSecond [50] [4];
	bool UseCOM; //
	char CompName    [50] [70];
	char Lock[200];
	char UnLock[200];
	char SharePath [200];
	bool Pipe;
	bool but_Type;
	bool but_Zalog;
	bool but_Raschet;
	bool but_Edit;
	bool CloseExplorer;
	bool BlockInet;
	char GateWayName [200];
	double Tarif1;
	double Tarif2;
	double Tarif3;
	double Tarif4;
	double Tarif5;
	double Tarif6;
	double Tarif7;
	double Tarif8;
	char PathName [200];
	MD5_CTX m_md5;
*/
	char INomer[200]; //��� ����
	char IName[200]; // ������������ ����
	char Lock[200];  // ������� ��� ����������
	char UnLock[200];  // ������� ��� �������������
	//
	int nDopList; // �-�� ���.����� � ����� usl.ini
	//
	bool UseCassa;  // �������� �������� ���
	bool UseRF2160; // true - �������� ��� �� ��, false - �� �������
	bool UseBoth;  // ������ ���������� ����
	char PathBill [200]; //���� ����������� ����� ����� ��������� ��������
	//
	int CountComp; // �-�� ������� �������
	char CompName    [MAX_WORKSTATION] [70]; // ������ ���� ������� �������
	bool bActiv	[MAX_WORKSTATION]; // true - ������� �������� ����� ������������, false - ��� (���������, ����������)
	bool BlockInet; // ����������� ��������
	bool CloseExplorer; // ����������� ���������
	char GateWayName [200]; // IP Gateway
	bool Pipe; // ������� ������������� Pipes, ����� - Socket
	// ������ ������ �� ��������
	double Tarif1;  //Internet ������� 8-21
	double Tarif2;  //Computer ������� 8-21
	//
	double Tarif3;  //Internet �������� 21-8
	double Tarif4;  //Computer �������� 21-8
	//
	double Tarif5;  //Internet �����������
	double Tarif6;  //Computer �����������
	//
	double Tarif7;  //Student Internet �������
	double Tarif8;  //Student Internet �����������
	//
	char SharePath [200]; // ���� � ����� �����
	char PathName [200]; // ���� � ���������� � ���������� (����������� ���������.)
	//
	MD5_CTX m_md5;
} hOldSetup;

struct Bill
{
	SYSTEMTIME TimeBeg;
	double Tarif;
	int Time;
	double Sum;
};

typedef struct CompInfo
{
	HANDLE hCom;
	int NumbComp;  // ����� ������� �� ���-�� hSetup
	char CompName [70]; // ������������ ������� �� ���-�� hSetup
	SYSTEMTIME DateTimeBeg; // ���� ������ ����� ������ �� �������� ������
	int Elapce;		// ���������� ������� �� �������� ������
	int TPos;		// ��� �������� ������
	bool bTarif;	// ������ �� ��� ��� ������ � ��������
	bool sTarif;	// ������ � �������� - �������������
	bool cTarif;	// ������ �� ��� ��� ������ � �������� - �������������
	double Tarif;	// ������� �����
	bool Start;		// ������� ������ ������� (t - ������, f - �������� ��� ���������� �����)
	bool Rasch;		// ������� ������� � �������� (t - �� ���������, f - ������ ��������)
	bool Connected;	// ������� ����������� ������� �������
	double AllZalog;	// ����� ������� ������
	double Zalog;		// �������� ������� ������ ��� �������� �������
	int Time;			// ������� ������� ������ ������	
	double Ostatok;		// ������� ������� ������
	CString sStudFio;	// ��� ����.������ - ���
	CString sStudNum;	// ��� ����.������ - ����� �������, ������
	int nBills;			//�-�� �������� �� ������ ������� 
	Bill * Bills;		// ������� �� ������ ������� (��� ��������� ������)
} hCompInfo;

double Round(double dSum, long lPrec=2);
//
void ClearComp(CompInfo *Comp);
//
void LogWrite(char *text);
// ��� ��������� ������
int Except (unsigned int code, struct _EXCEPTION_POINTERS *ep, CString ProcName);

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_STDAFX_H__78696A72_83ED_11D4_945E_0050044D962D__INCLUDED_)
