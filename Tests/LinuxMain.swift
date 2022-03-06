import XCTest
import Quick

@testable import GitTests

QCKMain([
    FixturesSpec.self,
    SignatureSpec.self,
    CommitSpec.self,
    TreeEntrySpec.self,
    TreeSpec.self,
    BlobSpec.self,
    TagSpec.self,
    OIDSpec.self,
    ReferenceSpec.self,
    BranchSpec.self,
    TagReferenceSpec.self,
    RemoteSpec.self,
    RepositorySpec.self,
])
