//
//  XLEFoundationMacroUtils.h
//  Pods
//
//  Created by Randy on 16/3/4.
//
//

#ifndef XLEFoundationMacroUtils_h
#define XLEFoundationMacroUtils_h

// 两种 weakself 写法
#define __XLEWeakSelf__  __weak typeof (self)

#define XLEWS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


#define __XLEWeakObject(object) __weak typeof (object)

#define XLEWeakifyself __XLEWeakSelf__ wSelf = self;
#define XLEStrongifyself __XLEWeakSelf__ self = wSelf;

#define XLEWeakifyobject(obj) __XLEWeakObject(obj) $##obj = obj;
#define XLEStrongifobject(obj) __XLEWeakObject(obj) obj = $##obj;

#endif /* XLEFoundationMacroUtils_h */
