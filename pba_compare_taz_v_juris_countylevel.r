
library(ggplot2)
library(ggthemr)
ggthemr('fresh')

juris_taz<- read.csv(file.path(Sys.getenv('DROPBOX_LOC'),'Data/pba2040_compare_jurisdata_to_tazdata_countylevel.csv'))
pdf('c:/Users/akselo/Dropbox/plots/pba2040_compare_taz_juris_countylevel.pdf',width=17,height=11)

for(variable in (levels(juris_taz$variable))){
  
  pl<-ggplot(data=juris_taz[juris_taz$county!='REGION' &
                                      juris_taz$variable==variable
                                    #juris_taz$source!='acs2010-1yr'
                                    ,],
             aes(x=year,fill=level_3,y=value)) + 
    geom_bar(stat='identity',position='dodge')+
    
    #coord_flip() +
    xlab('')+ylab('') +
    facet_wrap(~county,scales='free') +
    scale_y_continuous(labels=comma) +
    geom_text(aes(y=value*.9,label = comma(floor(value/1000))),angle=90, 
              position = position_dodge(width=3.5),
              color='white')+
    theme(axis.text.x =element_text(angle=90,size=9),
          strip.text.x = element_text(size=10, angle=0,face="bold"),
          strip.text.y = element_text(size=10, face="bold")) +
    theme(legend.position = "bottom") +
    labs(title=sprintf('%s\nPBA 2040 comparison of taz data to juris data at county-level aggregation',toupper(variable)),
         subtitle='Source: run7224_juris_summaries_{yyyy}.csv, run7224c_taz_summaries_{yyyy}.csv; \nrun7224_baseyear_juris_summaries_2010.csv, run7224c_baseyear_taz_summaries_2010.csv')
  pl<-pl+guides(col = guide_legend(nrow = 2,byrow = TRUE))
  print(pl)
}
dev.off()
