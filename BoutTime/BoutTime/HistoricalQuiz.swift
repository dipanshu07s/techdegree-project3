//
//  HistoricalQuiz.swift
//  BoutTime
//
//  Created by Dipanshu Sehrawat on 16/04/19.
//  Copyright © 2019 Dipanshu Sehrawat. All rights reserved.
//

import Foundation

protocol Quiz {
    var events: [Event] { get }
    func round() -> [Event]
}

class HistoricaQuiz {
    var events: [Event] = [
        Event(title: "Wikipedia is launched", year: 2011, url: URL(string: "https://en.wikipedia.org/wiki/Wikipedia")),
        Event(title: "Google is launched", year: 1998, url: URL(string: "https://en.wikipedia.org/wiki/Google")),
        Event(title: "World Wide web is announced", year: 1991, url: URL(string: "https://en.wikipedia.org/wiki/World_Wide_Web")),
        Event(title: "Apple introduced Macintosh", year: 1984, url: URL(string: "https://en.wikipedia.org/wiki/Macintosh")),
        Event(title: "Microsoft announces Windows", year: 1983, url: URL(string: "https://en.wikipedia.org/wiki/Microsoft_Windows")),
        Event(title: "Apple II was released", year: 1977, url: URL(string: "https://en.wikipedia.org/wiki/Apple_II")),
        Event(title: "Steve Jobs and Woniak launch Apple I", year: 1975, url: URL(string: "https://en.wikipedia.org/wiki/Apple_I")),
        Event(title: "Intel 8080 comes out", year: 1974, url: URL(string: "https://en.wikipedia.org/wiki/Intel_8080")),
        Event(title: "Ethernet developed at Xerox PARC", year: 1973, url: URL(string: "https://en.wikipedia.org/wiki/Ethernet")),
        Event(title: "Ray Tomlinson invents email", year: 1971, url: URL(string: "https://en.wikipedia.org/wiki/Email")),
        Event(title: "First nodes of ARPANET installed", year: 1969, url: URL(string: "https://en.wikipedia.org/wiki/ARPANET")),
        Event(title: "Whole Earth Catalog was published", year: 1968, url: URL(string: "https://en.wikipedia.org/wiki/Whole_Earth_Catalog")),
        Event(title: "Donald Davies coins the term packet switching", year: 1966, url: URL(string: "https://en.wikipedia.org/wiki/Packet_switching")),
        Event(title: "Moore's Law predicts microchips will double every year", year: 1965, url: URL(string: "https://en.wikipedia.org/wiki/Moore%27s_law")),
        Event(title: "Engelbart and Bill English invent the mouse", year: 1963, url: URL(string: "https://en.wikipedia.org/wiki/Computer_mouse")),
        Event(title: "MIT hackers create Spacewar game", year: 1962, url: URL(string: "https://en.wikipedia.org/wiki/Spacewar!")),
        Event(title: "President Kennedy proposes sending man to the moon", year: 1961, url: URL(string: "https://en.wikipedia.org/wiki/Moon")),
        Event(title: "Noyce and Fairchild colleagues invent microchip", year: 1959, url: URL(string: "https://en.wikipedia.org/wiki/Integrated_circuit")),
        Event(title: "Advanced Research Projects Agency (ARPA) announced", year: 1958, url: URL(string: "https://en.wikipedia.org/wiki/ARPANET")),
        Event(title: "Russia launches Sputnik", year: 1957, url: URL(string: "https://en.wikipedia.org/wiki/Sputnik_1")),
        Event(title: "First artificial intelligence conference", year: 1956, url: URL(string: "https://en.wikipedia.org/wiki/Artificial_intelligence")),
        Event(title: "Turing commits suicide", year: 1954, url: URL(string: "https://en.wikipedia.org/wiki/Alan_Turing")),
        Event(title: "Grace Hopper developes first computer compiler", year: 1952, url: URL(string: "https://en.wikipedia.org/wiki/Grace_Hopper")),
        Event(title: "Transistor invented at Bell Labs", year: 1947, url: URL(string: "https://en.wikipedia.org/wiki/Transistor")),
        Event(title: "Harvard Mark 1 goes into operation", year: 1944, url: URL(string: "https://en.wikipedia.org/wiki/Harvard_Mark_I"))
    ]
    
    func randomEvents() -> [Event] {
        var randomEvents = [Event]()
        
        for _ in 0...3 {
            let random = Int.random(in: 0..<events.count)
            randomEvents.append(events[random])
            events.remove(at: random)
        }
        
        return randomEvents
    }
}



















