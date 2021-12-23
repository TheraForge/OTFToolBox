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

extension OTFFileProtection {
    func fileExistsAt(_ path: String) throws -> Bool {
        let trimmedString = path.trimmingCharacters(in: .whitespaces)
        if trimmedString.isEmpty { throw OTFProtectionError.emptyFilePath }
        return fileManager.fileExists(atPath: path)
    }

    func encryptFile(_ type: FileProtectionType) throws {
        if #available(iOS 9.0, *) { // File Encryption is available from iOS 9.0 onwards
            let attributes = [ FileAttributeKey.protectionKey : type]
            try self.encrypt(attributes)

        }
    }

    // MARK: - Encrypt the file with given attributes. It can also throw an error that should be handled on user end.
    func encrypt(_ attributes: [FileAttributeKey: FileProtectionType]) throws {
        guard let path = self.filePath else { throw OTFProtectionError.emptyFilePath }
        guard try fileExistsAt(path) else { throw OTFProtectionError.fileNotFound}
        let url = URL(fileURLWithPath: path)
        try fileManager.setAttributes(attributes, ofItemAtPath: url.path)
    }

    // MARK: - Begin background task
    func beginBackgroundTask() {
        self.backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            self.endBackgroundTask()
        })
    }

    func endBackgroundTask() {
        if let identifier = self.backgroundTaskIdentifier {
            UIApplication.shared.endBackgroundTask(identifier)
        }
    }
}
#endif
