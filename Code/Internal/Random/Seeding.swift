#if os(iOS) || os(OSX)
import Darwin
#else
import Glibc
#endif

internal struct Seed {
#if os(iOS) || os(OSX)
	fileprivate static var bootTime: UInt {
		var bootTime = timeval()
		var mib = [ CTL_KERN, KERN_BOOTTIME ]
		var size = MemoryLayout<timeval>.stride
		sysctl(&mib, u_int(mib.count), &bootTime, &size, nil, 0)
		return UInt(bootTime.tv_sec) + UInt(bootTime.tv_usec)
	}

	fileprivate static var CPUTime: UInt {
		return 0
	}

	
	internal static func generate() -> [UInt] {
		// todo: add in thread time, cpu time, cpu load, processor load, memory usage

		return [
			UInt(mach_absolute_time()),
			bootTime,
//			threadTime,
//			CPUTime,
			UInt(getpid()),
			UInt(time(nil)),
			UInt(pthread_mach_thread_np(pthread_self()))
		]
	}
#elseif os(Linux)
	
	internal static func generate() -> [UInt] {
		let seeds = [
			UInt(getpid()),
			UInt(time(nil)),
			UInt(pthread_mach_thread_np(pthread_self()))
		]

		// todo: add in processor load, memory usage
		let ids = [ CLOCK_MONOTONIC_RAW, CLOCK_BOOTTIME,
					CLOCK_PROCESS_CPUTIME_ID, CLOCK_THREAD_CPUTIME_ID ]
		return ids.map { return clock($0) } + seeds
	}

	private static func clock(id: clockid_t) -> UInt {
		var ts: timespec = timespec()
		return withUnsafeMutablePointer(&ts) { (time) -> UInt in
			clock_gettime(id, time)
			return UInt(time.memory.tv_sec) + UInt(time.memory.tv_nsec)
		}
	}
#endif
}
