//+------------------------------------------------------------------+
//|                                                 Lang/Integer.mqh |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, Li Ding"
#property link      "dingmaotu@hotmail.com"
#property strict

#include "Native.mqh"

#define CHAR_BITS 8
#define SHORT_BITS 16
#define INT_BITS 32
#define LONG_BITS 64
#define DBL_BITS 64
#define FLT_BITS 32

struct Double;
struct Single;
struct Int64;
struct Int32;

#import "kernel32.dll"
void RtlMoveMemory(Double &dest,const Int64 &src,size_t length);
void RtlMoveMemory(Int32 &dest,const Single &src,size_t length);
void RtlMoveMemory(Int64 &dest,const Double &src,size_t length);
#import
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
struct Int8
  {
   char              value;
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
struct Int16
  {
   short             value;
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
struct Int32
  {
   int               value;
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
struct Int64
  {
   long              value;
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
struct Single
  {
   float             value;
   static const float NaN;
   static const float NegativeInfinity;
   static const float PositiveInfinity;

   static bool IsNaN(const float value)
     {
      return value==0xFFFF000000000000;
     }
   //+------------------------------------------------------------------+
   //| Returns a value indicating whether the specified number evaluates|
   //| to positive infinity.                                            |
   //+------------------------------------------------------------------+      
   static bool IsPositiveInfinity(const float value)
     {
      return value==0x7FF0000000000000;
     }
   //+------------------------------------------------------------------+
   //| Returns a value indicating whether the specified number evaluates|
   //| to negative infinity.                                            |
   //+------------------------------------------------------------------+       
   static bool IsNegativeInfinity(const float value)
     {
      return value==0xFFF0000000000000;
     }
   //+------------------------------------------------------------------+
   //| Returns a value indicating whether the specified number evaluates|
   //| to negative or positive infinity.                                |
   //+------------------------------------------------------------------+     
   static bool IsInfinity(const float value)
     {
      return (Single::IsNegativeInfinity(value) || Single::IsPositiveInfinity(value));
     }
  };
const float Single::NegativeInfinity=(float)-MathExp(DBL_MAX);
const float Single::PositiveInfinity=(float)MathExp(DBL_MAX);
const float Single::NaN=(float)Single::PositiveInfinity/Single::NegativeInfinity;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
struct Double
  {
   double            value;
   static const double NaN;
   static const double NegativeInfinity;
   static const double PositiveInfinity;
   //+------------------------------------------------------------------+
   //| Returns a value indicating whether the specified number evaluates|
   //| to positive infinity.                                            |
   //+------------------------------------------------------------------+
   static bool IsPositiveInfinity(const double value)
     {
      Int64 s;
      s.value=0x7FF0000000000000;
      Double t;
      RtlMoveMemory(t,s,sizeof(Int64));
      return value==t.value;
     }
   //+------------------------------------------------------------------+
   //| Returns a value indicating whether the specified number evaluates|
   //| to negative infinity.                                            |
   //+------------------------------------------------------------------+      
   static bool IsNegativeInfinity(const double value)
     {
      Int64 s;
      s.value=0xFFF0000000000000;
      Double t;
      RtlMoveMemory(t,s,sizeof(Int64));
      return value==t.value;
     }
   //+------------------------------------------------------------------+
   //| Returns a value indicating whether the specified number evaluates|
   //| to negative or positive infinity.                                |
   //+------------------------------------------------------------------+      
   static bool IsInfinity(const double value)
     {
      return (Double::IsNegativeInfinity(value) || Double::IsPositiveInfinity(value));
     }
   //+------------------------------------------------------------------+
   //| Returns a value that indicates whether the specified value is not|
   //| a number (NaN).                                                  |
   //+------------------------------------------------------------------+ 
   static bool IsNaN(const double value)
     {
      return (!MathIsValidNumber(value) && !IsInfinity(value));
     }
  };
const double Double::NegativeInfinity=-MathExp(DBL_MAX);
const double Double::PositiveInfinity=MathExp(DBL_MAX);
const double Double::NaN=Double::PositiveInfinity/Double::NegativeInfinity;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
struct LargeInt
  {
   int               lowPart;
   int               highPart;
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
struct IntBytes
  {
   uchar             value[8];
   string            toString() const;
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string IntBytes::toString(void) const
  {
   return StringFormat("0x|%02x_%02x_%02x_%02x|%02x_%02x_%02x_%02x|",value[7],value[6],value[5],value[4],value[3],value[2],value[1],value[0]);
  }
//+------------------------------------------------------------------+
