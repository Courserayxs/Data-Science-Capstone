
<style>

.exclaim .reveal .state-background {
  background: black;
} 

.exclaim .reveal h1,
.exclaim .reveal h2,
.exclaim .reveal p {
  color: white;
}
</style>



Data Science Capstone - Course Project
========================================================
author: John Cleveland
date: 01/02/2017
transition: rotate
autosize: true

 Word Prediction 
========================================================
type:exclaim
class: small-code

<p> <small> We all love our <span style="font-weight:bold; color:yellow;"> SWIFTKEY KEYBOARDS </span> and <span style="font-weight:bold; color:yellow;"> GOOGLE SEARCH </span> ... some more than others ... </small> </p>

<img src= "googleit.jpg" style="display:block; margin-left:auto; margin-right: auto" > </img>
<p><small>
 <span style="font-weight:bold; color:yellow;"> AUTOCOMPLETER </span> is a word predictor deployed using R framework: R language, R markdown , R Presenter, R Shiny ... R everything!!! </small></p>

 <p><small> Both word predictor and autocompleter! Fast Accurate !  Trained on blog, news and twitter data !   </small></p>

Under the Hood
========================================================
#type:section

AUTOCOMPLETER uses n-gram Linear Interpolation Smoothing

 if  $\lambda = ( \lambda_0, \lambda_1, \lambda_2, \lambda_3):$ 
 
The formulas are :
$p_{\lambda}( w_i|w_{i-3}, w_{i-2}, w_{i-1}) = \lambda_4 p_{4}( w_i|w_{i-3}, w_{i-2}, w_{i-1})$
$+ \lambda_3 p_3( w_i| w_{i-2}, w_{i-1}) + \lambda_2 p_2( w_i| w_{i-1}) + \lambda_1 p_1( w_i) + \lambda_0/ |V|$

- Normalize:
$\lambda_i >0$ , $\sum \lambda_i =1$

One can choose the $\lambda_i 's$ according to some criteria or utilize MLE:
<http://www.cs.jhu.edu/~hajic/courses/cs465/cs46506/ppframe.htm>



Example Usage of Application
========================================================
type:exclaim

Just start typing !!

<img src= "autocompleter.png" style="display:block; margin-left:auto; margin-right: auto" > </img>

<p> <small>The application drops down a menu with the top five word choices or autocompletions. It displays words if the last character is nonspace character and word choices if it is a space character. It highlights the choices in yellow and you can just click to select... easy as pie !
</small></p>
Screen Shot
========================================================
type:exclaim

The source code can be obtained at the following repository :

<https://github.com/johncleveland/Data-Science-Capstone>

A prototype of AUTOCOMPLETER has been developed and deployed at:

<https://yxs8495.shinyapps.io/Capstone_app/>

For more details on authoring R presentations please visit <https://support.rstudio.com/hc/en-us/articles/200486468>.
