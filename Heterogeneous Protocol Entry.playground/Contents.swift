import Foundation

enum CollectionType: Decodable {
    case accelerometer(SensorTelemetryCollectionType)
    case activity(BaseCollectionType)
    case distance(BaseCollectionType)
    case eventLog(BaseCollectionType)
    case gyroscope(SensorTelemetryCollectionType)
    case location(BaseCollectionType)
    case step(BaseCollectionType)
    case audio(RecordingCollectionType)
    case image(BaseCollectionType)
    case video(BaseCollectionType)
    case unknown
    
    init(from decoder: Decoder) throws {
        let singleValueContainer = try decoder.singleValueContainer()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            switch try container.decode(Unassociated.self, forKey: .type) {
            case Unassociated.accelerometer: self = .accelerometer(try singleValueContainer.decode(SensorTelemetryCollectionType.self))
            case Unassociated.activity: self = .activity(try singleValueContainer.decode(BaseCollectionType.self))
            case Unassociated.distance: self = .distance(try singleValueContainer.decode(BaseCollectionType.self))
            case Unassociated.eventLog: self = .eventLog(try singleValueContainer.decode(BaseCollectionType.self))
            case Unassociated.gyroscope: self = .gyroscope(try singleValueContainer.decode(SensorTelemetryCollectionType.self))
            case Unassociated.location: self = .location(try singleValueContainer.decode(BaseCollectionType.self))
            case Unassociated.step: self = .step(try singleValueContainer.decode(BaseCollectionType.self))
            case Unassociated.audio: self = .audio(try singleValueContainer.decode(RecordingCollectionType.self))
            case Unassociated.image: self = .image(try singleValueContainer.decode(BaseCollectionType.self))
            case Unassociated.video: self = .video(try singleValueContainer.decode(BaseCollectionType.self))
            }
        } catch {
            assertionFailure("CollectionType was unable to handle type. Report this bug to the maintainers. \(error.localizedDescription)")
            self = .unknown
        }
    }
    
    enum Unassociated: String, Decodable {
        case accelerometer = "ACCELEROMETER"
        case activity = "ACTIVITY"
        case distance = "DISTANCE"
        case eventLog = "EVENT_LOG"
        case gyroscope = "GYROSCOPE"
        case location = "LOCATION"
        case step = "STEPS"
        case audio = "AUDIO"
        case image = "IMAGE"
        case video = "VIDEO"
    }
    
    private enum CodingKeys: String, CodingKey {
        case type
    }
}

class BaseCollectionType: Decodable, Identifiable, Equatable, CustomDebugStringConvertible {
    let id: UUID
    let schedules: [ProtocolEntrySchedule]
    
    enum CodingKeys: String, CodingKey {
        case id, schedules
    }
    
    static func == (lhs: BaseCollectionType, rhs: BaseCollectionType) -> Bool {
        lhs.id == rhs.id
    }
    
    var debugDescription: String {
        "BaseProtocolEntry(id: \(id), schedules: \(schedules))"
    }
}

final class SensorTelemetryCollectionType: BaseCollectionType {
    enum CodingKeys: String, CodingKey {
        case frequencyHz
    }
    
    let frequencyHz: Int
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        frequencyHz = try container.decode(Int.self, forKey: .frequencyHz)
        try super.init(from: decoder)
    }
    
    override var debugDescription: String {
        "SensorTelemetryProtocolEntry(id: \(id), schedules: \(schedules), frequencyHz: \(frequencyHz))"
    }
}

final class RecordingCollectionType: BaseCollectionType {
    enum CodingKeys: String, CodingKey {
        case maxDurationSeconds
    }
    
    let maxDurationSeconds: Int
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        maxDurationSeconds = try container.decode(Int.self, forKey: .maxDurationSeconds)
        try super.init(from: decoder)
    }
    
    override var debugDescription: String {
        "AudioProtocolEntry(id: \(id), schedules: \(schedules), maxDurationSeconds: \(maxDurationSeconds))"
    }
}

struct ProtocolEntrySchedule: Decodable, Identifiable, CustomDebugStringConvertible {
    @propertyWrapper
    struct Identifier<T>: Decodable where T: Hashable & Decodable {
        var wrappedValue: T
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            wrappedValue = try container.decode(T.self)
        }
    }

    @Identifier
    var id: UUID
    let cronSchedule: String
    let durationSeconds: Int
    let startDayOffset: Int
    let endDayOffset: Int
    
    var debugDescription: String {
        "ProtocolEntrySchedule(id: \(id), cronSchedule: \(cronSchedule), durationSeconds: \(durationSeconds), startDayOffset: \(startDayOffset), endDayOffset: \(endDayOffset))"
    }
}

// MARK: - Test code 🤞

let json = Data("""
[
    {
        "id": "d6950093-1bf1-48d4-9efa-b4af89901457",
        "type": "ACCELEROMETER",
        "schedules": [
            {
                "id": "1a10b221-c2c8-40a2-9c67-d591c115cad9",
                "cronSchedule": "0 0 9-5 * * ?",
                "durationSeconds": 30,
                "startDayOffset": 0,
                "endDayOffset": 10
            }
        ],
        "frequencyHz": 50
    },
    {
        "id": "4103d81c-d0d6-487e-be6c-019f5080e743",
        "type": "STEPS",
        "schedules": []
    },
    {
        "id": "aa8bd337-137e-4f00-acff-90be02e5b5ba",
        "type": "LOCATION",
        "schedules": []
    },
    {
        "id": "8e5f3584-e343-4fa0-9eff-a64143dd9ac3",
        "type": "GYROSCOPE",
        "schedules": [],
        "frequencyHz": 100
    },
    {
        "id": "cdf00bf3-6a08-47f9-a029-d5f52e497815",
        "type": "DISTANCE",
        "schedules": []
    },
    {
        "id": "5ba22044-37aa-478a-ae85-55a56b2d02c4",
        "type": "AUDIO",
        "schedules": [],
        "maxDurationSeconds": 60
    },
    {
        "id": "af821a36-2d3d-42a1-85b5-d1abf35a4f70",
        "type": "ACTIVITY",
        "schedules": []
    },
    {
        "id": "fa8f18ee-b055-4078-9d56-72af18a92339",
        "type": "ACCELEROMETER",
        "schedules": [],
        "frequencyHz": 100
    }
]
""".utf8)

do {
    let decoded = try JSONDecoder().decode([CollectionType].self, from: json)
    decoded.forEach {
        print($0)
    }
} catch {
    debugPrint("Failed to decode", error)
}
