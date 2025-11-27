# Efficient Small Language Model–Driven Personalized Press Release Distribution: From Draft‑to‑Impact with Adaptive Packages, Closed‑Loop Analytics, and Pay‑Per‑Click Gap‑Filling

## Abstract
Generally, enterprises and businesses charge multiple packages for their products and services to their clients. Similarly, traditional Press Release (PR) distribution relies on static packages and broad syndication; however, these distribution packages often misalign cost with expected impact.

The research proposes a system that analyzes a client’s draft press release using a pipeline of Small Language Models (SLMs) plus retrieval augmentation to recommend a customized, value-based distribution package. The system ranks outlets and add‑ons (regional boosts, multimedia, timing) via a hybrid recommender combining compact semantic embeddings, historical performance features, and a budgeted multi-objective optimizer. The work introduces the notion of an “Adaptive Impact Package” (AIP) tailored to the release’s content and objectives as an alternative to fixed tiers.

The proposed architecture combines compact semantic embeddings, retrieval augmentation, multimodal (text plus image) features, a budgeted multi‑objective optimizer (relevance, pickups, click‑through rate (CTR), conversions, earned media value (EMV), cost), and an explainability layer. The research will conduct offline experiments that compare the prototype with static packages and classical recommenders, focusing on impact‑per‑dollar, ranking quality, calibration, latency and computational cost, and client‑facing trust. The aim is to investigate whether SLM‑based pipelines, when carefully engineered and constrained, can approach the recommendation quality of larger models while remaining more efficient and practical for realistic deployment scenarios.

## Motivation
- Market Gap: Enterprise wire services and mid‑tier platforms sell broad, static bundles; clients often overpay for low‑relevance distribution.
- Opportunity: Personalized, content‑driven package assembly that tailors spend to predicted impact; supports transparent return on investment (ROI).
- Practical Constraint: Full‑scale large language models (LLMs) add latency, cost, and opacity. Small Language Models (SLMs) enable faster inference, on‑premises governance, reproducibility, and sustainability.
- Evertise Fit: The “Adaptive Impact Package” as an artificial intelligence (AI)–driven, trustable, cost‑efficient alternative to one‑size‑fits‑all tiers.

## Problem Statement
Given a draft press release and budget constraints, generate a personalized distribution package (outlets plus add‑ons) that maximizes a utility function over predicted relevance, pickups, click‑through rate (CTR), conversions, and earned media value (EMV), with diversity and policy constraints—and adapt post‑launch via analytics and pay‑per‑click (PPC) advertising gap‑filling.

## Research Questions
1. To what extent can SLM‑based embeddings and retrieval improve outlet relevance, compared with term frequency–inverse document frequency (TF‑IDF) and matrix‑factorization (MF) baselines, when using the distributor taxonomy and historical outcomes?
2. Under realistic budget and policy constraints, does a budgeted multi‑objective optimizer yield higher impact‑per‑dollar than static packages when restricted to SLM‑derived features?
3. In which settings, if any, do lightweight multimodal features (e.g., CLIP text–image signals) provide additional benefit for visually oriented verticals?
4. Can template‑ and retrieval‑based explanations provide levels of client trust and understanding that are comparable to, or acceptable alternatives to, paragraph‑style LLM rationales?
5. How effectively can cross‑time analytics combined with PressEcho‑style PPC campaigns reduce performance gaps without inducing excessive additional spend?

## Objectives
- Build a compact, explainable recommender prototype for content‑to‑outlet matching using Small Language Model (SLM) embeddings and the distributor’s category taxonomy.
- Implement a simple budget‑aware package construction step (for example, greedy or knapsack‑style) that assembles a set of outlets under a cost constraint.
- Run offline experiments comparing the SLM‑based recommender against baseline methods (for example, term frequency–inverse document frequency (TF‑IDF), popularity, or rule‑based heuristics) using ranking and impact‑per‑dollar style metrics.
- Design and implement explanation templates that present key topics/entities, similarities to historical examples, and a simple cost/impact summary for recommended packages.
- Collect limited qualitative feedback from a small number of stakeholders on the clarity and perceived usefulness of recommendations and explanations.

Aspects such as a fully automated pay‑per‑click (PPC) gap‑filling loop, complex multi‑objective optimization with many constraints, and online A/B testing are out of scope for this research.

## System Overview
1) Draft/Metadata (AI Writer)
- Inputs: issuer/company, topic, category, dateline, tone, quotes (verbatim), keywords, assets.
- Outputs: PR draft + structured metadata (category, keywords, tone, length)—stored to DB; moderation and quote enforcement.

2) Targeting Taxonomy (AI Distributor)
- Database‑ready master categories + slugs seeded to `press_release_categories`.
- Used for candidate outlet retrieval, rules (region/vertical/language), and constraint templates (e.g., Finance compliance).

3) Recommender + Optimizer (This Thesis)
- SLM Embeddings: MiniLM/bge‑small (quantized) for PR and outlet profiles (learned from historic PR–outlet interactions).
- Retrieval: FAISS/HNSW for candidate outlets; filters (category, region, language).
- Reranker: Distilled cross‑encoder (~110M params) over features: semantic similarity, historical pickup/CTR, sentiment compatibility, CLIP image similarity (if assets), coverage diversity.
- Optimizer: Multi‑objective utility U = α·Relevance + β·PickupProb + γ·CTR + δ·EMV − λ·Redundancy − μ·PolicyRisk; subject to Σ cost ≤ Budget, diversity constraints, editorial policies; OR‑Tools (ILP/knapsack).
- Output: “Adaptive Impact Package” (AIP): outlets + add‑ons (multimedia, translation, timing), KPI bands, explanations, cost.

4) Reporting & Analytics
- Schema: `distribution_report(press_release_id, site_id, published_url, views, published_at, updated_at)`.
- Workflow: publication detection → pixel/JS view tracking → cross‑time report.
- Role: generates evidence, feeds features back to the model (incremental updates), and computes gap metrics.

5) PressEcho PPC Gap‑Filling
- Inputs: PR metadata, distribution report, site inventory, external audience data.
- Output: targeting matrices for Google Search, Meta, Display (keywords, geos, demographics, suggested bids/budgets) with `campaign_gap_score`.
- Role: compensates underperforming channels and integrates back into analytics for continuous optimization.

6) Explanations & Compliance
- Templates: top topics/entities, historical analog PRs, predicted KPI bands, cost/impact chart, AEO/structured‑data checks.
- Policy: region/language filters, finance/health flags, quote‑verbatim enforcement, moderation before distribution.

## Methodology (SLM‑First, Efficient)
- Embeddings: sentence‑transformers MiniLM/bge‑small (int8/4‑bit quantization).
- NER/Topics: spaCy + KeyBERT; sentiment with distilled RoBERTa.
- Multimodal: CLIP ViT‑B/32 for optional image relevance fused with text embeddings (used only if data quality and time permit).
- Candidate Generation: ANN over outlet vectors; taxonomy filters + compliance gates.
- Reranking: Distilled cross‑encoder trained on soft labels (optional teacher) + historical success labels, subject to data availability.
- Optimization: A simple greedy or knapsack‑style budget‑aware selector that assembles outlet sets under cost constraints.

## Data & Governance
- Internal (anonymized): PR drafts/metadata, distribution logs, publication URLs, views (pixel/JavaScript), pickups/CTR/conversions, costs.
- External: Competitor feeds already in `data/` for outlet taxonomy features and baselines.
- Schema alignment: `distribution_report`, `press_release_categories`, `press_echo_targeting`/`press_echo_performance`.
- Privacy: No PII in modeling; quotes kept verbatim as per SRS; moderation and policy checks applied.

## Evaluation Plan
- **Ranking Quality:**  
	Evaluate outlet ranking using normalized discounted cumulative gain at K (NDCG@K) and Recall@K, comparing the proposed SLM‑based pipeline against TF‑IDF and MF baselines, and, where available, against a stronger teacher model (inter‑model Kendall τ).

- **Utility & Calibration:**  
	Assess probabilistic outputs using metrics such as Brier score for pickup and CTR predictions and calibration curves for EMV and conversion estimates; report the accuracy and calibration of predicted KPI bands.

- **Package Efficiency:**  
	Compare impact‑per‑dollar between personalized packages produced by the optimizer and current static packages (e.g., relevant pickups, qualified sessions, or similar proxy KPIs per unit cost) using offline replay experiments.

- **Component Ablations:**  
	Conduct ablation studies that remove or vary key components (retrieval, multimodal features, distillation, PressEcho loop) to quantify their marginal contribution to ranking and impact‑per‑dollar.

- **Robustness:**  
	Examine behavior in challenging regimes such as cold‑start outlets, niche verticals, multilingual releases, and seasonal drift, documenting where performance degrades and which mitigation strategies are most effective.

- **Operational Metrics:**  
	Measure latency, memory footprint, and approximate energy or cost per recommendation under realistic deployment constraints for SLM‑based components.

- **Trust & Usability:**  
	Run a small‑scale user study (e.g., with internal stakeholders) to gather qualitative and quantitative feedback on explanation clarity, perceived fairness, and willingness to adopt customized packages relative to static tiers.

- **Optional Online or Quasi‑Online Evaluation:**  
	Where organizational approval and traffic permit, conduct a limited A/B or quasi‑online evaluation comparing Adaptive Impact Packages with standard packages, focusing on changes in qualified conversions, media pickups, or other agreed‑upon business KPIs.

## Timeline
- **Month 1 – Data, Problem Framing, and Baselines**
	- Audit available data sources (press releases, outlet lists, any historical placements or pickups).
	- Define the recommendation problem formally and specify evaluation metrics (for example, relevance at K and a proxy for earned media value (EMV) per unit cost).
	- Implement and evaluate baseline recommenders such as TF‑IDF and a simple popularity or rule‑based heuristic.

- **Month 2 – SLM Recommender Prototype**
	- Implement SLM‑based embeddings for press releases and outlets and set up candidate retrieval.
	- Add a simple reranking component using SLM‑derived features.
	- Implement a budget‑aware package construction step (for example, greedy or knapsack‑style) to generate a recommended set of outlets under cost constraints.
	- Design and implement explanation templates for the recommended packages.

- **Month 3 – Evaluation, Feedback, and Write‑Up**
	- Run offline experiments comparing SLM‑based recommendations with the baselines using ranking metrics (such as normalized discounted cumulative gain at K (NDCG@K) and Recall@K) and impact‑per‑dollar‑style metrics.
	- Conduct a small qualitative feedback exercise with a few internal stakeholders to assess explanation clarity and perceived usefulness.
	- Analyze quantitative and qualitative results, document limitations, and refine the proposed approach accordingly.
	- Complete the written report, summarizing methodology, results, limitations, and prioritized directions for future work (for example, full multi‑objective optimization and PPC gap‑filling).

## Expected Contributions
1. An implemented Small Language Model (SLM)–based recommender prototype for personalized press release outlet selection, designed to operate under realistic time and resource constraints and evaluated against simple baseline methods.
2. A lightweight, budget‑aware package construction procedure for assembling outlet sets under cost constraints, together with an offline evaluation protocol based on ranking quality and a proxy for earned media value (EMV) per unit cost.
3. A set of explanation templates and representative example outputs that demonstrate how SLM‑based recommendations can be made more interpretable for non‑technical stakeholders.
4. Empirical evidence from offline experiments about the conditions under which an SLM‑based recommender offers improvements over baseline approaches such as term frequency–inverse document frequency (TF‑IDF) and popularity‑based methods for press release distribution.
5. A concise, reproducible experimental setup (data splits, metrics, and scripts) and a documented set of limitations and future‑work directions, including more advanced multi‑objective optimization, integration of pay‑per‑click (PPC) data, and online experimentation.

## Risks & Mitigations
- Sparse or delayed outcomes → Use proxy KPIs (early views, sentiment) and confidence bands.
- Cold‑start outlets/topics → Metadata priors, category‑level averages, retrieval of nearest neighbors.
- Multilingual needs → LaBSE or bge‑m3 embeddings; lightweight translation fallback.
- Compliance & policy → Rule‑based gates, moderation per SRS; enforce quote‑verbatim and AEO/structured‑data checks.

## Adaptive Impact Package (Client‑Facing)
- Deliverable: A recommended, budgeted package with predicted KPI bands (pickups/CTR/EMV), cost breakdown, rationale (topics/entities, historical analogs), diversity map, and optional PPC add‑on for projected gaps.
- Upsell Logic: “Frontier view” showing marginal impact vs cost to let clients flex budget rationally.

## Implementation Snapshot (Technical)
Module | Stack
--- | ---
Embeddings | sentence‑transformers MiniLM / bge‑small (quantized)
Retrieval | FAISS (HNSW)
NER/Topics | spaCy + KeyBERT
Reranker | Distilled cross‑encoder (~110M params)
Optimizer | OR‑Tools ILP / knapsack + diversity penalty
Multimodal | CLIP ViT‑B/32 + linear fusion
Sentiment | Distilled RoBERTa classifier
Explanations | Template assembler + retrieved evidence
Online Update | Nightly partial MF retrain + embedding refresh

## Deliverables
- Thesis manuscript + defense deck
- Prototype recommender implementation (SLM + retrieval + simple budget‑aware selector) with explanation templates
- Evaluation notebooks and scripts for offline experiments, including basic cost/latency measurements where feasible
- Reproducibility bundle (configs, seeds, versions)
- Ethics/Compliance appendix (moderation, answer engine optimization (AEO), privacy)

## One‑Page Proposal Defense Slide Outline

- Problem & Opportunity (1–2 bullets)
	- Static PR packages misalign cost with impact; clients overpay for low relevance.
	- Personalized, budgeted packages can increase impact‑per‑dollar using efficient SLMs.
- Approach (diagram anchor)
	- SLM embeddings + retrieval → candidate outlets → distilled reranker → budgeted optimizer.
- Data & Modules (traceability)
	- AI Writer (metadata, quotes, moderation), Distributor taxonomy, distribution_report schema, PressEcho targeting.
- Optimization Objective
	- Maximize α·Relevance + β·Pickups + γ·CTR + δ·EMV − λ·Redundancy − μ·PolicyRisk, s.t. cost ≤ budget, diversity/compliance.
- Evaluation Plan
	- Ranking (NDCG/Recall), impact‑per‑dollar vs static packages, calibration, latency/cost, trust survey.
- Risks & Mitigations
	- Sparse signals → proxy KPIs; cold‑start → metadata priors; drift → incremental updates.
- Timeline & Deliverables
	- Phases covering data audit and baselines, prototype SLM recommender and budgeted selector, and offline evaluation and write‑up.

## Architecture Diagram (ASCII)

```text
												 +--------------------+
												 |   Client / Admin   |
												 |   UI & Checkout    |
												 +---------+----------+
																	 |
																	 v
				 +-----------------+   PR Draft + Metadata   +------------------------+
				 |   AI Writer     |------------------------>|   Recommender Stack    |
				 | (SRS module)    |                         | (SLM + Retrieval +     |
				 +--------+--------+                         |  Distilled Reranker)   |
									|                                  +-----------+------------+
									|  Quotes, Category, Keywords                  |
									v                                              v
				 +-------------------------+                    +----------------------+
				 | Distributor Taxonomy    |                    |  Optimizer (ILP)     |
				 | (press_release_categories)|                  |  Budget & Constraints |
				 +------------+------------+                    +----------+-----------+
											|                                           |
											| Candidates, Rules                         | AIP (Outlets + Add‑ons)
											v                                           v
							 +------+--------------------+               +------+------------------+
							 | Distribution Execution    |               | Explanations & Policy  |
							 | (existing workflows)      |               | Checks (templates, AEO)|
							 +------+--------------------+               +-----------+------------+
											|                                             |
											v                                             v
				 +------------+--------------------+            +-----------+------------+
				 | Reporting & Analytics (DB)      |            |  PressEcho PPC Engine |
				 | distribution_report: URLs,views |<-----------|  (targeting matrices)  |
				 +------------+--------------------+   gaps     +-----------+------------+
											^                                             |
											|   incremental features / updates            |
											+---------------------------------------------+
												 closed‑loop optimization (6–8h cadence)
```

## SRS/DB Requirement Mapping Checklist (Defense Q&A)

AI Writer (functional requirements)
- FR‑001/002 (Form & validation): Provides structured metadata (topic, category, dateline, tone, keywords) → used by Recommender candidate filters and features.
- FR‑003 (Generation) & FR‑006/008 (Admin & re‑gen): Draft lifecycle integrates upstream of recommendation; prompts are out‑of‑scope for ranking logic.
- FR‑004 (Quote verbatim enforcement): Enforced pre‑distribution; Optimizer rejects packages failing compliance gates.
- FR‑005 (Preview/Export): Orthogonal; thesis consumes stored drafts/metadata only.
- FR‑007 (Moderation): Policy gate before recommendation/distribution; risk term μ·PolicyRisk penalizes flagged content.
- FR‑009/010/011 (Notify, rate‑limit, admin): Operational; non‑blocking for modeling—documented in deployment notes.

AI Writer (non‑functional)
- NFR‑001/002 (Latency/Concurrency): SLMs + quantization ensure <1s typical inference for embeddings/reranker on modest GPUs/CPU.
- NFR‑006–NFR‑010 (Security/Privacy): Keys server‑side; PII excluded from modeling; moderation applied.
- NFR‑013/014 (Logging): Recommender logs model/version, seeds, costs for reproducibility.

Press Release AI Distributor (taxonomy)
- Schema: `press_release_categories` seeded from master list → used for outlet vertical mapping, filters, diversity constraints.
- Role: Improves candidate precision; supports cold‑start via category priors.

Reporting & Analytics (DB + workflow)
- Schema: `distribution_report(press_release_id, site_id, published_url, views, published_at, updated_at)`.
- Publication detection + pixel/JS views → compute early KPIs; feed incremental features to recompute pickups/CTR estimates.
- Cross‑time report used to calculate `gap_score = (expected_views − actual_views)/expected_views` for PressEcho.

PressEcho – Post Distribution (targeting & automation)
- Matrices: Google Search, Meta, Display with expanded keywords, geos, demographics, suggested bids; stored in `press_echo_targeting`.
- Performance feedback saved in `press_echo_performance`; informs budget reallocation and continuous optimization.
- Integration point: invoked when gap_score exceeds threshold; complements organic distribution.

Thesis Components Mapping
- SLM Recommender: embeddings, retrieval, reranker → aligns with Writer metadata, Distributor taxonomy.
- Optimizer: budgeted ILP, diversity & policy constraints → produces AIP.
- Analytics Pipeline: ingests distribution_report; updates models; drives gap detection.
- PressEcho Integration: generates targeting matrices; closes loop; measures lift.
- Explainability & Compliance: templates, historical analogs, AEO checks; quote‑verbatim gate via SRS.
- Governance: logging, privacy, moderation consistent with SRS NFRs.
