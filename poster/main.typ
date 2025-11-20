#import "@preview/peace-of-posters:0.5.6" as pop

#let theme = (
    "body-box-args": (
        inset: 0.6em,
        width: 100%,
    ),
    "body-text-args": (:),
    "heading-box-args": (
        inset: 0.6em,
        width: 100%,
        fill: rgb("#0B1F3A"),
        stroke: rgb("#0B1F3A"),
    ),
    "heading-text-args": (
        fill: white,
    ),
)

#set page("a0", margin: 1cm, fill: white)
#pop.set-poster-layout(pop.layout-a0)
#pop.set-theme(theme)
#set text(size: pop.layout-a0.at("body-size"))
#let box-spacing = 1.2em
#set columns(gutter: box-spacing)
#set block(spacing: box-spacing)
#pop.update-poster-layout(spacing: box-spacing)

#let nyx-black  = rgb("#0A0A0A")
#let nyx-violet = rgb("#6D28D9")
#let nyx-cyan   = rgb("#06B6D4")
#let nyx-amber  = rgb("#F59E0B")
#let nyx-accent = gradient.linear(nyx-violet, nyx-cyan)
#let nyx-faint  = rgb(0, 0, 0)

#let hba = pop.uni-fr.heading-box-args
#hba.insert("fill", white)
#hba.insert("inset", 16pt)
#hba.insert("stroke", (paint: nyx-accent, thickness: 8pt))

#let bba = pop.uni-fr.body-box-args
#bba.insert("fill", white)
#bba.insert("inset", 28pt)
#bba.insert("stroke", (paint: nyx-faint, thickness: 0.75pt))

#let hta = pop.uni-fr.heading-text-args
#hta.insert("fill", nyx-black)

#let column = pop.column-box.with(
  heading-box-args: hba,
  body-box-args: bba,
  heading-text-args: hta,
)

#box(
  inset: 10pt,
  stroke: (paint: nyx-accent, thickness: 8pt),
  fill: nyx-accent,
)[
  #pop.title-box(
    [
      #text(fill: white)[
        Automating Lean-Based Formal Verification of Cryptographic Protocols with a Peer-Review-Gated AI Agent
      ]
    ],
    authors: "Banri Yanahama¹",
    institutes: "¹Nyx Foundation",
    keywords: "Formal Verification, Cryptographic Protocols, Lean, AI Agents",
    logo: square(image("nyx_logo_square_white.png"), fill: white, inset: -5pt),
  )
]

#columns(2,[
  #column(heading: "Abstract")[
    This paper proposes a pipeline that uses an AI agent to automate Lean-based formal verification of cryptographic protocols.

    The method adopts a two-stage gate design:
    
    (i) generation of informal proofs in natural language;

    (ii) an accept/reject decision by a reviewer role;
    
    (iii) generation and verification of Lean proofs that formalize only the accepted drafts.

    To the best of our knowledge, there has been no prior report in the public literature on the systematic application of Lean-generating AI agents to the domain of cryptographic protocols.
  ]

  #column(heading: "Background")[
    Formal verification is increasingly required for cryptographic protocols that underpin critical infrastructure. Compared with testing alone, it makes attacker models and security claims explicit and mechanically checkable. In this project we:
    - target proofs in Lean, an interactive theorem prover with dependent types, tactics, and a rich mathematical library;
    - leverage AI agents that iteratively reason, plan, and act across natural language and Lean code;
    - focus on security proofs for cryptographic protocols, a domain where Lean-based AI agents have not yet been systematically studied.

    Our goal is to build a gated automation pipeline that turns informal security arguments into Lean developments that can be checked and reproduced.
  ]

  #column(heading: "Proposed Method")[
    Figure 1 situates our setting within AI-assisted formal proof research (e.g., #cite(<Aristotle>), #cite(<PALM>), #cite(<CryptoFormalEval>)).

    #figure(
      image("result1_quadrant_graph.png", width:75%),
      caption: "Position of Our Work in AI-Assisted Formal Proof Research"
    )

    And the pipeline starts from a target proposition, chooses a Focal Theorem, and incrementally introduces the smallest set of Focal Stub Lemmas needed to complete its proof.

    - Three phases—Retrieval, Exploration, Conclusion—structure the workflow from collecting specifications to synchronizing verified Lean proofs.
    - Within Exploration, rounds pass through the gates IW → IR → FW → FR → FS; the Focal Theorem and all Focal Lemmas always share the same state.
  ]

  #column()[
    #figure(
      image("overall_flow.png"),
      caption: "Overall Flow of the Proposed Pipeline"
    )

    - A unified state model tracks each proposition as an informal or formal stub or artifact, while Lean imports define dependencies and the CLI orchestrates rounds via package scripts.

    This design keeps the search focused, auditable, and convergent to Lean-checked security proofs.
  ]

  #column(heading: "Result")[
    We applied the pipeline to the security proposition for the Top Single Layer encoding, a building block of the quantum-resistant signature scheme XMSS. A run was counted as successful if it carried the proposition from an informal draft to a Lean development that passed all reviewer gates and reached the FS stage with Lean checking completed.

    #figure(
      image("table.png", width: 90%),
      caption: "Trial Results for Top Single Layer Encoding Verification",
    )
    // - Three independent trials were executed with separate histories and artifacts.  
    // - All three trials succeeded (3/3); completion times ranged from 21 to 115 minutes.  
    // - Across trials, the mean completion time was 83 minutes (median 113), with on average 3.0 rounds (median 4), 16.3 turns (median 22), and 2.0 newly introduced lemmas (median 3).  
    // - One trial followed a short path (1 round, 5 turns, no new lemmas), whereas the others followed longer paths (4 rounds, 22 turns, 3 new lemmas), reflecting additional lemma introduction and review iterations.

    Overall, the agent consistently converged to final verification for this proposition.
  ]

  #column(heading: "Discussion")[
    Combining a two-stage gate design with focal decomposition yielded successful Lean verification in all three trials, both for a short path without new lemmas and for longer paths with additional lemmas. Future work includes:

    - Apply the pipeline to additional protocols and properties (e.g., EUF-CMA for signatures, security proofs for zkSNARKs).
    - Systematically ablate reviewer gates and their checklists to quantify their contribution to success, runtime, and rollback behavior.

  ]

  #column(heading: "Key Reference")[
    #bibliography("bibliography.bib", title:none)
  ]

])


#pop.bottom-box()[
  For further details: https://github.com/NyxFoundation/fv-agent-cans-poster
]
