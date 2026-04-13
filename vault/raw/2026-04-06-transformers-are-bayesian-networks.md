---
url: "https://arxiv.org/abs/2603.17063"
title: "Transformers are Bayesian Networks"
date_fetched: 2026-04-06
clipping: "[[Clippings/Transformers are Bayesian Networks]]"
---

# Transformers are Bayesian Networks

- **Authors:** Gregory Coppola
- **Submitted:** 2026-03-17
- **Categories:** cs.AI
- **arXiv:** 2603.17063

## Abstract

Transformers are the dominant architecture in AI, yet why they work remains poorly understood. This paper offers a precise answer: a transformer is a Bayesian network. We establish this in five ways. First, we prove that every sigmoid transformer with any weights implements weighted loopy belief propagation on its implicit factor graph. One layer is one round of BP. This holds for any weights -- trained, random, or constructed. Formally verified against standard mathematical axioms. Second, we give a constructive proof that a transformer can implement exact belief propagation on any declared knowledge base. On knowledge bases without circular dependencies this yields provably correct probability estimates at every node. Formally verified against standard mathematical axioms. Third, we prove uniqueness: a sigmoid transformer that produces exact posteriors necessarily has BP weights. There is no other path through the sigmoid architecture to exact posteriors. Formally verified against standard mathematical axioms. Fourth, we delineate the AND/OR boolean structure of the transformer layer: attention is AND, the FFN is OR, and their strict alternation is Pearl's gather/update algorithm exactly. Fifth, we confirm all formal results experimentally, corroborating the Bayesian network characterization in practice. We also establish the practical viability of loopy belief propagation despite the current lack of a theoretical convergence guarantee. We further prove that verifiable inference requires a finite concept space. Any finite verification procedure can distinguish at most finitely many concepts. Without grounding, correctness is not defined. Hallucination is not a bug that scaling can fix. It is the structural consequence of operating without concepts. Formally verified against standard mathematical axioms.

## Five Main Results

### 1. Sigmoid Transformer = Weighted Loopy Belief Propagation
Every sigmoid transformer with any weights implements weighted loopy belief propagation on its implicit factor graph. One layer corresponds to one round of BP. This holds regardless of weight initialization (trained, random, or constructed).

### 2. Exact Belief Propagation on Knowledge Bases
Constructive proof that a transformer can implement exact belief propagation on any declared knowledge base. On knowledge bases without circular dependencies, this yields provably correct probability estimates at every node.

### 3. Uniqueness of BP Weights
A sigmoid transformer that produces exact posteriors necessarily has BP weights. There is no other path through the sigmoid architecture to exact posteriors.

### 4. AND/OR Boolean Structure
- Attention = AND operation
- FFN (Feed-Forward Network) = OR operation
- Their strict alternation follows Pearl's gather/update algorithm exactly

### 5. Experimental Confirmation
All formal results confirmed experimentally, corroborating the Bayesian network characterization in practice. Practical viability of loopy belief propagation established despite the current lack of theoretical convergence guarantee.

## On Hallucination
Verifiable inference requires a finite concept space. Any finite verification procedure can distinguish at most finitely many concepts. Without grounding, correctness is not defined. Hallucination is not a bug that scaling can fix — it is the structural consequence of operating without concepts.
