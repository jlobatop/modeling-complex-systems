# Modeling of Complex Systems 
In this repository, the different codes created for the assignments of the course CSYS302 have been uploaded. MATLAB was the programming language used to create the functions and the scripts. The reports for each assignment were created with LaTeX. 

* *Course*: CS/CSYS 302
* *Instructor*: Margaret (Maggie) Eppstein
* *Text:*  G.W. Flake, *The Computational Beauty of Nature*, MIT Press, 2000

> All models are wrong, but some are useful - George E. P. Box

## Homework 1: Fractals and Lindenmayer systems

#### Part A - Basic fractal code
An already existing code of the **L-system expansion** was slightly corrected to improve the performance and correct some unexpected behavior. Implementation of the integer multipliers (`+` and `-`) and the **L-system plotting** was also added. Finally, a nature-inspired fractal was created.

#### Part B - Advanced L-system code
Beginning with the code from Part A, **other L-system operators** were added (such as `|`). Also, some **stochastic L-systems** were created in order to add more realism to the different figures. 

## Homework 2: Numerical methods

#### Part A - Numerical differentiation
The backward and central first order schemes for **numerical differentiation** were analyzed to determine their behavior on different scenarios, obtaining the three distinct regions in the associated error plots: truncation, round-off and machine epsilon. **Error and timestep analysis** were performed, deriving the optimal timestep size for the central differences method as well as the numerical approximation of the second order derivative. 

#### Part B - Numerical integration and chaos
Using the value obtained with a Runge-Kutta method of order 4-5 (`ode45`) the **stability of numerical methods** was tested (comparing Euler's and Heun's **numerical integration methods**) in a Lotka-Volterra system. The **accuracy of the numerical methods** was also considered in the study, using relative errors between different measures. 

## Homework 3: Cellular Automata (CA)

#### Part A - Greenberg-Hastings CA model
A Greenberg-Hastings cellular automata with an epidemiological model (choosing the **Susceptibles-infectious-recovered (SIR) model**) was coded. It included stochastic simulations with different infection probabilities, synchronous and asynchronous updating and immigration rate. The plotting is automatized and fancy animations can be obtained.

#### Part B - CA research experiment
With modifications in the code of the previous part of the assignment, a **fire spreading model** was coded for a cellular automata. Some analysis on the topic was conducted: the main question was the effect of different number of fires focus on a forest fire. 

## Homework 4: Swarm models

#### Part A - BOIDS swarm model
A swarm model implementation was coded to show some collective behavior of smaller individuals. The basic rules of attraction, orientation and repulsion rules of the **BOIDS swarm model** were used. The neighborhood chosen was a mix between a circular zone of repulsion and a field of view of the boid. Predator repulsion of the whole flock and later cohesion was also implemented. 

#### Part B - Swarm experiment
The code implemented before had a neighborhood of the intersection of a circular zone of repulsion and a field of view. ** Other kinds of neighborhoods** were implemented (such as the *k-nearest* or *field of view + k-nearest*) and the results and behavior of the flock were analyzed under a parameter sweep. 

## Homework 5: Random Boolean Networks (RBN)

#### Part A - Dynamics on NK-RBNs
First an **overview of boolean networks** was done in a simple case (not an NK case), just to settle down the concepts. Then a broader analysis was performed, looking at the **stability** of different NK-RBN with the Derrida plots for a range of K values. 

#### Part B - Dynamics on heterogeneous RBNs
A more versatile code was implemented, having that custom boolean networks may be used (as the one studied in Part A). Also, a **Poisson distributed boolean network** was used to compare the stability of the system with the Derrida plots of the previous part. 