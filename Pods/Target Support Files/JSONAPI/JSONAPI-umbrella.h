#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "JSONAPI.h"
#import "JSONAPIErrorResource.h"
#import "JSONAPIPropertyDescriptor.h"
#import "JSONAPIResource.h"
#import "JSONAPIResourceBase.h"
#import "JSONAPIResourceDescriptor.h"
#import "JSONAPIResourceParser.h"
#import "NSDateFormatter+JSONAPIDateFormatter.h"

FOUNDATION_EXPORT double JSONAPIVersionNumber;
FOUNDATION_EXPORT const unsigned char JSONAPIVersionString[];

