#set document(author: "Reza Gholizadeh", title: "Reza Gholizadeh")
#let accent-color = "#26428b"
#let author-position = left
#let author-font-size = 20pt
#let personal-info-position = left

#set page(
  margin: 0.5in,
  paper: "a4",
  footer: text(
    size: 9pt,
    [Revision #datetime.today().display(), Latest Version: #link("https://ceng.metu.edu.tr/~e2490258/CV.pdf")[ceng.metu.edu.tr/\~e2490258/CV.pdf]],
  ),
)

#set text(
  // LaTeX style font
  font: "New Computer Modern",
  size: 10pt,
  lang: "en",
  // Disable ligatures so ATS systems do not get confused when parsing fonts.
  ligatures: false,
)

#show link: underline

// Small caps for section titles
#show heading.where(level: 2): it => [
  #pad(top: 0pt, bottom: -10pt, [#smallcaps(it.body)])
  #line(length: 100%, stroke: 1pt)
]

// Accent Color Styling
#show heading: set text(
  fill: rgb(accent-color),
)

#show link: set text(
  fill: rgb(accent-color),
)

// Name will be aligned left, bold and big
#show heading.where(level: 1): it => [
  #set align(author-position)
  #set text(
    weight: 700,
    size: author-font-size,
  )
  #pad(it.body)]


= Reza Gholizadeh

// Personal Info
// HACK LinkedIn link shouldn't start with `https`
// TODO for now, my website link is on its own line. Eyeball whether it looks bad after compiling.
#pad(
  top: 0.25em,
  align(personal-info-position)[
    #{
      let items = (
        link("tel:" + sys.inputs.at("my-phone-number", default: "<REDACTED>"))[#sys.inputs.at(
          "my-phone-number",
          default: "<Phone Number Redacted>",
        )],
        sys.inputs.at("my-location", default: "Türkiye"),
        link("mailto:" + sys.inputs.at("my-email", default: "<REDACTED>"))[#sys.inputs.at(
          "my-email",
          default: "<name>.<surname>[at]metu.edu.tr",
        )],
        link("https://github.com/RezaOnGithub")[#text(font: "Font Awesome 7 Brands")[\u{f09b}] RezaOnGithub],
      )
      if sys.inputs.at("my-linkedin", default: "") != "" {
        items.push(link("https://linkedin.com/in/" + sys.inputs.at("my-linkedin", default: ""))[#text(font: "Font Awesome 7 Brands")[\u{f08c}] #sys.inputs.at("my-linkedin", default: "")])
      }
      items.filter(x => x != none).join("  |  ")
    } \
    #link(
      "https://ceng.metu.edu.tr/~e2490258",
    )[#text(font: "Font Awesome 7 Brands")[\u{f02e}] ceng.metu.edu.tr/\~e2490258]
  ],
)

// Start of Body
#set par(justify: true)


// Generic two by two component for resume
#let generic-two-by-two(
  top-left: "",
  top-right: "",
  bottom-left: "",
  bottom-right: "",
) = {
  [
    #top-left #h(1fr) #top-right \
    #bottom-left #h(1fr) #bottom-right
  ]
}

// Generic one by two component for resume
#let generic-one-by-two(
  left: "",
  right: "",
) = {
  [
    #left #h(1fr) #right
  ]
}

// Cannot just use normal --- ligature because ligatures are disabled for good reasons
#let dates-helper(
  start-date: "",
  end-date: "",
) = {
  if start-date == "" {
    end-date
  } else {
    start-date + " " + sym.dash.em + " " + end-date
  }
}

#let edu(
  institution: "",
  dates: "",
  degree: "",
  gpa: "",
  location: "",
  // Makes dates on upper right like rest of components
  consistent: false,
) = {
  if consistent {
    // edu-constant style (dates top-right, location bottom-right)
    generic-two-by-two(
      top-left: strong(institution),
      top-right: dates,
      bottom-left: emph(degree),
      bottom-right: emph(location),
    )
  } else {
    // original edu style (location top-right, dates bottom-right)
    generic-two-by-two(
      top-left: strong(institution),
      top-right: location,
      bottom-left: emph(degree),
      bottom-right: emph(dates),
    )
  }
}

== Education

#edu(
  institution: "Middle East Technical University",
  location: "Anakara, Türkiye",
  dates: dates-helper(start-date: "Oct 2020", end-date: "Present"),
  degree: "Bachelor's of Computer Engineering",

  // Uncomment the line below if you want edu formatting to be consistent with everything else
  // consistent: true
)
- Noteworthy Coursework: #list(
    [Computer Security (CENG489)],
    [Language Processors (Compilers, CENG444)],
    [Graphics I (CENG477)],
    [Philosophy of Computer Science (COGS579)],
  )

#edu(
  institution: "Shahid Madani SAMPAD High School",
  location: "Tabriz",
  dates: dates-helper(start-date: "2017", end-date: "2019"),
  degree: "Diploma",
)

- "Math/Physics" major, CGPA $18.94/20$ 

== Projects

#let project(
  role: "",
  name: "",
  url: "",
  dates: "",
) = {
  generic-one-by-two(
    left: {
      if role == "" {
        [*#name* #if url != "" and dates != "" [ (#link("https://" + url)[#url])]]
      } else {
        [*#role*, #name #if url != "" and dates != "" [ (#link("https://" + url)[#url])]]
      }
    },
    right: {
      if dates == "" and url != "" {
        link("https://" + url)[#url]
      } else {
        dates
      }
    },
  )
}

#project(
  name: "StayWise (DemoDay '26)",
  // Role is optional
  role: "Backend Developer",
  // Dates is optional
  dates: dates-helper(start-date: "Oct 2025", end-date: "June 2026"),
  // URL is also optional
  url: "senior.ceng.metu.edu.tr/2026/StayWise",
)
- A hotel recommendation system combining traditional approaches with LLMs and a review database RAG. Worked on the backend integration.

#project(
  name: "Compiler in C++",
  dates: dates-helper(end-date: "June 2025"),
)

- An optimizing compiler for a simple programming language as a part of CENG444 coursework. (not public) Optimizations include code-motion, inlining, strength-reduction, etc.


#project(
  name: "Software Rasterizer in C++",
  role: "Team Member",
  dates: dates-helper(end-date: "May 2025"),
  url: "github.com/RezaOnGithub/CENG477HW2",
)

- CPU-based triangle rasterization group project. (2-person) Part of Graphics I coursework.


== Certificates

#let certificates(
  name: "",
  issuer: "",
  url: "",
  date: "",
) = {
  [
    *#name*, #issuer
    #if url != "" {
      [ (#link("https://" + url)[#url])]
    }
    #h(1fr) #date
  ]
}

#certificates(
  name: "TOEFL iBT",
  issuer: "Educational Testing Service",
  date: dates-helper(end-date: "June 2020"),
)

- English language test. 109 out of 120 points. (30/30/24/25)

// == Extracurricular
//
// #let extracurriculars(
//   activity: "",
//   dates: "",
// ) = {
//   generic-one-by-two(
//     left: strong(activity),
//     right: dates,
//   )
// }

== Skills

- *Programming Languages*: Rust, C/C++, Python, SQL
- *Technologies*: CMake, `uv`, LangChain, Pydantic, FastAPI, SQLite, PostgreSQL, Coding Agents (Preferred: `codex`)
