<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.math.*"%>
<%@page import="java.util.*"%>
<%
/*
staffuse,staffuse,seat,seat,seat,seat,seat,seat:staffuse,staffuse,seat,seat,seat,seat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat]seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:staffuse,staffuse,seat,seat,seat,seat,seat,seat:staffuse,staffuse,seat,seat,seat,seat,seat,seat]seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,seat,seat,seat,seat,staffuse,staffuse:seat,seat,seat,seat,seat,seat,staffuse,staffuse]seat,seat,seat,seat,seat,seat,staffuse,staffuse:seat,seat,seat,seat,seat,seat,staffuse,staffuse:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat]staffuse,staffuse,seat,seat,seat,seat,seat,seat:staffuse,staffuse,seat,seat,seat,seat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat]
*/
String data = "staffuse,staffuse,seat,seat,seat,seat,seat,seat:staffuse,staffuse,seat,seat,seat,seat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat]seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:staffuse,staffuse,seat,seat,seat,seat,seat,seat:staffuse,staffuse,seat,seat,seat,seat,seat,seat]seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,seat,seat,seat,seat,staffuse,staffuse:seat,seat,seat,seat,seat,seat,staffuse,staffuse]seat,seat,seat,seat,seat,seat,staffuse,staffuse:seat,seat,seat,seat,seat,seat,staffuse,staffuse:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat]staffuse,staffuse,seat,seat,seat,seat,seat,seat:staffuse,staffuse,seat,seat,seat,seat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat]seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:staffuse,staffuse,seat,seat,seat,seat,seat,seat:staffuse,staffuse,seat,seat,seat,seat,seat,seat]seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,seat,seat,seat,seat,staffuse,staffuse:seat,seat,seat,seat,seat,seat,staffuse,staffuse]";
//String data = "seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:staffuse,staffuse,seat,seat,seat,seat,seat,seat:staffuse,staffuse,seat,seat,seat,seat,seat,seat]";
String[] dataArray = data.split("]");

String[][][] out1 = new String[dataArray.length][][];

out.println(dataArray.length + "<BR>");
/*
for(int i=0;i<dataArray.length;i++){
    String[] innerArray = dataArray[i].split(":");
    out1[i] = new String[innerArray.length][];
    for(int j=0;j<innerArray.length;j++){
        String[] valueArray = innerArray[j].split(",");
        out1[i][j] = new String[valueArray.length];
        for(int k=0;k<valueArray.length;k++){
            out1[i][j][k] = valueArray[k];
            out.println(out1[i][j][k]);
        }out.println("<BR>");
    }out.println("<BR>");
}
out.println(out1.length + "<BR>=========================<BR>"); 
*/

int roomCount = 0;
int floor = 1;
int roomIndex = 2;
String[][][] out2 = new String[dataArray.length][][];
String mapdata = "";
int count1 = 0;
int count2 = 0;

for(int i=0;i<dataArray.length;i++){
    String[] innerArray = dataArray[i].split(":");
    out2[i] = new String[innerArray.length][];
    count2 = 0;
    for(int j=0;j<innerArray.length;j++){
        String[] valueArray = innerArray[j].split(",");
        out2[i][j] = new String[valueArray.length];
        count1 = 0;
        for(int k=0;k<valueArray.length;k++){
        	if (i + 1 == floor && roomCount == roomIndex) {
            	out2[i][j][k] = "occupied";
            }else{
        		out2[i][j][k] = valueArray[k];
            }
        	
        	if (count1 == out2[i][j].length - 1) {
                if (count2 != out2[i].length - 1) {
                    //out.print(value + ":");
                    mapdata += out2[i][j][k] + ":<BR>";
                } else {
                    //out.print(value);
                    mapdata += out2[i][j][k];
                }
            } else {
                //out.print(value + ",");
                mapdata += out2[i][j][k] + ",";
            }
            count1++;
            
        	out.println(out2[i][j][k]);
            roomCount++;
        }
        if (count2 == out2[i].length - 1) {
            //out.print("]");
            mapdata += "]<BR><BR>";
        }
        count2++;
        out.println("<BR>");
    }
    roomCount = 0; 
    out.println("<BR>");
}

out.println("<BR>============================<BR>"+mapdata);
/*
String[] dataArr = data.split("]");
out.println(dataArr.length + "<BR>"); 

List<List<List<String>>> out1 = new ArrayList<>();
int step = 0;
int last = dataArr.length;
String className = "seat";

for (int i = 0; i < last; i++) {
    String[] items = dataArr[i].split(":");
    List<List<String>> itemList = new ArrayList<>();
    for (int j = 0; j < items.length; j++) {
        String[] values = items[j].split(",");
        List<String> valueList = new ArrayList<>();
        for (int k = 0; k < values.length; k++) {
            valueList.add(values[k]);
            out.println(values[k]);
        }out.println("<BR>");
        itemList.add(valueList);
    }out.println("<BR>");
    out1.add(itemList);
}
*/
out.println("<BR>=============================================================================<BR>");


/*
for (int i = 0; i < out1.size(); i++) {
    for (int j = 0; j < out1.get(i).size(); j++) {
        for (int k = 0; k < out1.get(i).get(j).size(); k++) {
            if (i + 1 == floor && roomCount == roomIndex) {
                out1.get(i).get(j).set(k, "occupied");
            }
            roomCount++;
        }
    }
    roomCount = 0;
}
*/
%>