#! /usr/bin/env ruby
require 'statsample'
sample=200
a=sample.times.collect {rand}.to_scale
b=sample.times.collect {rand}.to_scale
c=sample.times.collect {rand}.to_scale
d=sample.times.collect {rand}.to_scale

ds={'a'=>a,'b'=>b,'c'=>c,'d'=>d}.to_dataset

# Set the dependent variable

ds['y']=ds.collect{|row| row['a']*5+row['b']*3+row['c']*2+row['d']+rand()}
rb=ReportBuilder.new(:name=>"Example of Regression Analysis")
# Add a correlation matrix
cm=Statsample::Bivariate.correlation_matrix(ds)
rb.add(cm)
# Add a Linear Regression
lr=Statsample::Regression::Multiple::RubyEngine.new(ds,'y')
rb.add(lr)

puts rb.to_text
rb.save_rtf("dominance_analysis.rtf")
rb.save_html("dominance_analysis.html")