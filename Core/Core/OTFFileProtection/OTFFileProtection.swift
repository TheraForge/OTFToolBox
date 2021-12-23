/*
Copyright (c) 2021, Hippocrates Technologies S.r.l.. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.

3. Neither the name of the copyright holder(s) nor the names of any contributor(s) may
be used to endorse or promote products derived from this software without specific
prior written permission. No license is granted to the trademarks of the copyright
holders even if such marks are included in this software.

4. Commercial redistribution in any form requires an explicit license agreement with the
copyright holder(s). Please contact support@hippocratestech.com for further information
regarding licensing.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
OF SUCH DAMAGE.
 */

#if TARGET_OS_IPHONE
import UIKit

@objc public class OTFFileProtection: NSObject {
    public static let shared: OTFFileProtectionProvider = OTFFileProtection()
    var filePath: String!
    let fileManager = FileManager.default
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier!
}


extension OTFFileProtection: OTFFileProtectionProvider {

    @objc public func setProtection(_ level: OTFProtectionLevel, at path: String) throws {
        if try fileExistsAt(path) {
            self.filePath = path
            try self.applyProtection(level)
        } else {
            throw OTFProtectionError.fileNotFound
        }
    }
}

extension OTFFileProtection {
    private func applyProtection(_ level: OTFProtectionLevel) throws {
        switch level {
        case .runToCompletionWithIn10Seconds:
            try self.setRunToCompletionModeWithIn10Sec(level)
        case .runToCompletionBeyond10Seconds:
            try self.setRunToCompletionBeyond10Sec(level)
        case .backgroundMode:
            try self.setBackgroundMode(level)
        }
    }

    func setRunToCompletionModeWithIn10Sec(_ level: OTFProtectionLevel) throws {
        try startWithDuration(level.rawValue)
    }

    func setRunToCompletionBeyond10Sec(_ level: OTFProtectionLevel) throws {
        try startWithDuration(level.rawValue)
    }

    func setBackgroundMode(_ level: OTFProtectionLevel) throws {
        self.beginBackgroundTask()
        try startWithDuration(level.rawValue)
    }

    func startWithDuration(_ second: Int) throws {
        let timeInterval = TimeInterval(second)
        try self.encryptFile(.completeUnlessOpen)
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { _ in
                try? self.encryptFile(.complete)
                self.endBackgroundTask()
            }
        } else {
            Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(encryptComplete), userInfo: nil, repeats: false)
        }
    }

    @objc
    private func encryptComplete() {
        try? self.encryptFile(.complete)
        self.endBackgroundTask()
    }
}
#endif
