# Thesis Proposal: Detailed Explanations & Q&A Transcript

This document compiles the "Plain English" explanations for the technical sections of the Thesis Proposal: *"Efficient Small Language Model–Driven Personalized Press Release Distribution"*.

---

## 1. Data & Governance
### Query: "What do you mean in data and governance 3rd bullet?"
**Text:** *Schema alignment: `distribution_report`, `press_release_categories`.*

**Explanation:**
This is about **"Connecting the Dots."**
*   **`distribution_report` (The Scorecard):** Tracks results (views, clicks, timestamps).
*   **`press_release_categories` (The Map):** Tracks structure (topics, industries).
*   **Alignment:** Ensures the AI can link *results* back to *categories*. For example, learning that "Crypto" PRs get more views on Tuesdays requires these two separate database tables to "talk" to each other perfectly.

---

## 2. Timeline
### Query: "What do you mean in timeline weeks 1-4?"
**Phase:** **Laying the Foundation (Doing the Homework)**
*   **Literature Review:** Studying existing solutions (SLMs, Recommender Systems) to avoid reinventing the wheel.
*   **Data Audit:** Checking the "cupboard" to ensure `evertise.net` has enough clean history.
*   **Preprocessing:** Anonymizing client data (removing secrets) and cleaning up the category list so the AI has good ingredients to cook with.

### Query: "What do you mean in timeline weeks 5-10?"
**Phase:** **Building the Engine (Coding)**
*   **The Translator (Embeddings):** Building the module that turns text into numbers (vectors) using quantized models like MiniLM.
*   **The Librarian (Retrieval):** Implementing FAISS to instantly search 10,000 outlets and find the top 100 matches.
*   **The Personal Shopper (Optimizer):** Writing the "Knapsack" math logic to fit the best outlets into a fixed budget ($500).
*   **The Safety Lock (Compliance):** Adding code to ensure quotes are never changed ("Verbatim Quote Enforcement").

### Query: "What do you mean in timeline weeks 11-12?"
**Phase:** **The Finish Line (Selling It)**
*   **The Report:** Writing the thesis manuscript. Turning code and data into a formal academic story.
*   **The Sales Pitch:** Creating the Defense Presentation to prove to professors that the "Adaptive Impact Package" works and is useful for real businesses.
*   **The Roadmap:** Honestly listing future work and limitations (e.g., "It works for English, but Spanish is next").

---

## 3. Expected Contributions
### Query: "What do you mean in Expected Contributions?"
**Explanation:** These are the "Gifts" your research gives to the world.
1.  **The Prototype:** A working blueprint showing that **Small Language Models (SLMs)** can do high-quality recommendations cheaply (without needing GPT-4).
2.  **The Budget Architect:** A specific mathematical method for solving the "Champagne taste on a beer budget" problem (maximizing impact within a fixed cost).
3.  **The Translator:** Templates that turn complex vector math into simple English explanations for clients.
4.  **The Manual:** A reproducibility bundle (code, configs, seeds) so other scientists can repeat your experiment.

---

## 4. Risks & Mitigations
### Query: "What do you mean in Risks & Mitigations section?"
**Explanation:** Playing "Devil's Advocate" (What could go wrong? vs. How we fix it).
1.  **Waiting Game (Delayed Outcomes):**
    *   *Risk:* We don't know if a PR is a "winner" for 2 weeks.
    *   *Fix:* Use "early clues" (views in the first hour) to predict the winner early.
2.  **New Kid on the Block (Cold Start):**
    *   *Risk:* A new outlet or topic appears with zero history.
    *   *Fix:* Use similarities. "I've never seen this site, but it looks like a Finance site, so I'll treat it as one."
3.  **Language Barrier:**
    *   *Risk:* Client sends a PR in Spanish.
    *   *Fix:* Use multilingual models (LaBSE) that understand concepts across languages.
4.  **Rogue AI:**
    *   *Risk:* AI hallucinates or changes a CEO's quote.
    *   *Fix:* Hard-coded "Guardrails" that forbid the AI from touching quotes or using banned words.

---

## 5. Adaptive Impact Package (Client-Facing)
### Query: "What do you mean in Adaptive Impact Package (Client‑Facing) section?"
**Explanation:** The "Menu" the customer sees.
*   **The Receipt of Value:** Instead of just a price tag, show **Predicted KPI Bands** ("You'll get 80-120 views") and **Rationale** ("We picked TechCrunch because...").
*   **The Upsell (Frontier View):** A negotiation tool. "You have a $500 budget, but for $50 more, you could get 200 extra views." It helps clients make rational spending decisions based on value, not just cost.

---

## 6. Implementation Snapshot (Technical)
### Query: "What do you mean in Implementation Snapshot (Technical) section?"
**Explanation:** The "Toolbox" (Tech Stack).
*   **Embeddings:** `MiniLM` / `bge-small` (Fast, lightweight text-to-number converters).
*   **Retrieval:** `FAISS` (Facebook's tool for searching millions of items instantly).
*   **NER/Topics:** `spaCy` + `KeyBERT` (Tools to find names and themes).
*   **Reranker:** `Distilled Cross-Encoder` (A highly accurate judge that double-checks the top results).
*   **Optimizer:** `OR-Tools` (Google's calculator for complex logistics/budget problems).
*   **Sentiment:** `Distilled RoBERTa` (Detects emotion).
*   **Explanations:** Templates + Evidence (Fills in the blanks to explain decisions).
*   **Online Update:** Nightly retraining (The AI learns from today's data while you sleep).

---

## 7. Deliverables
### Query: "What do you mean in Deliverables?"
**Explanation:** The physical/digital items you hand over to graduate.
1.  **The Paperwork:** The Thesis Manuscript (the book) and Defense Deck (the slides).
2.  **The Software:** The actual Python code for the Recommender and Templates.
3.  **The Recipe Kit:** A "Reproducibility Bundle" (configs, versions) so anyone can bake the same cake.
4.  **The Safety Manual:** An Ethics Appendix explaining how you handled moderation, privacy, and search engine optimization rules.

---

## 8. Architecture Diagram
### Query: "What do you mean in Architecture Design?"
**Explanation:** The Map of Data Flow.
1.  **Start:** Client inputs text -> **AI Writer** extracts "DNA" (Topic, Tone) and locks quotes.
2.  **Brain:** **Recommender Stack** searches 10,000 outlets (Retrieval) and ranks the top 100 (Reranker).
3.  **Decision:** **Optimizer** takes the top 100 + Client's Budget ($500) and calculates the perfect bundle.
4.  **Gatekeeper:** **Policy Checks** ensure no rules are broken.
5.  **Execution:** PR is published -> **Reporting DB** tracks views/clicks.
6.  **Loop:** The system learns from the results (Closed-loop optimization) to get smarter for next time.

---

## 9. Publication Potential
### Query: "Is this research proposal just a Prototype or can a paper also be published through this?"
**Verdict:** **Yes, it is highly publishable.**
*   **Hot Topic:** Shifts focus from "Big Models" to **"Efficient/Small Models"** (very trendy).
*   **Interdisciplinary:** Combines NLP (Language) with Operations Research (Math/Optimization).
*   **Real World:** Based on a case study (`evertise.net`), giving it industrial validity.
*   **Novelty:** Defines a new concept ("Adaptive Impact Package").
*   **Conclusion:** The Prototype is the *experiment*; the Paper is the *report*. You need the prototype to write the paper.
