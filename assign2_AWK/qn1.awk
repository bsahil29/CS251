#!/bin/awk
BEGIN{
        numofcomments=0
        numofstrings=0
        comment_startline=0
        comment_endline=0
        i=1
        j=1
        str_start=0
        str_end=0
        singlecmnt=0
        cmnt_start=0
        cmnt_end=0
    } 
        {
            if($0 ~ /\/\//)
            {   
                numofcomments ++
            }
            if($0 ~ /\/\*/ && $0 ~ /\*\//){
                numofcomments ++
            }
            if($0 ~ /\/\*/ && !($0 ~ /\*\//)){
                comment_startline= NR
            } 
            if(!($0 ~ /\/\*/) && $0 ~ /\*\//){
                comment_endline= NR
                numofcomments +=comment_endline-comment_startline+1
                comment_startline=0
                comment_endline=0
            }
            if( $0 ~ /\"/ ){
                if(! (NR > comment_startline && comment_startline !=0) )
                {
                     numofstrings ++ 
                }
                while(i<=NF){
                    if($i ~ /\"/){
                        str_start=i
                        i=NF
                    }
                    i ++
                }
                while(j<=NF){
                    if($j ~ /\"/){
                        str_end=j
                        j=NF
                    }
                j ++
                }
                i=1
                while(i<=NF){
                    if($i ~ /\/\//){
                        singlecmnt=i
                        if(singlecmnt < str_start && singlecmnt){
                            numofstrings --
                        }
                        if(singlecmnt <str_end && singlecmnt>str_start){
                            numofcomments --
                        }
                        i=NF
                    }i ++
                }
                i=1
                while(i<=NF){
                    if($i ~ /\/\*/){
                        cmnt_start=i
                        i=NF
                    }i ++
                }i=1
                while(i<=NF){
                    if($i ~ /\*\//){
                        cmnt_end=i                        
                        i=NF
                    }i ++
                }
                if(cmnt_start>str_start && cmnt_end<str_end && cmnt_end){
                    numofcomments --
                }
                if(cmnt_start<str_start && cmnt_end>str_end && str_end){
                    numofstrings --
                }
            }
        i=1
        j=1
        singlecmnt=0
        cmnt_start=0
        cmnt_end=0
        }
END {  
        print numofcomments," ", numofstrings 
    }