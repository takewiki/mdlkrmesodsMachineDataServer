

#' Title 预览数据
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples viewfnoteserver()
krmesMachineRptQuery <- function(input,output,session,dms_token) {

  var_dr_krmesMachineRptUI = tsui::var_dateRange('dr_krmesMachineRptUI')

    shiny::observeEvent(input$btn_krmesMachineRptUI_view,
                        {
                          dates = var_dr_krmesMachineRptUI()
                          startDate = as.character(dates[1])
                          endDate = as.character(dates[2])
                            sql = paste0("SELECT   [FBillNo] as 制令单号
      ,[FWorkshopid] as 车间
	   ,[FOperid] as 工序
	   ,[FSummary] as 机台号
      ,[FDate] as  日期
      ,[Fmaterialid] as 料号
      ,[FVeriety] as 品名
      ,[FOrderqty] as 订单量
      ,'pcs' as 生产单位
      ,[FPlanqty] as 计划数量
	  ,[FFinishqty] as 完工数量
      ,[FQualificationQty] as 良品数
      ,[FDefectsselQty] as 不良数
      ,[FOperator] as 操作员
  FROM [krmes].[dbo].[rds_mes_src_mfg_rpt]
  where FDate >='",startDate,"' and FDate <='",endDate,"'
  and FFinishqty > 0
  order by FDate desc,FSummary asc")
                            data = tsda::sql_select2(token = dms_token, sql = sql)
                            #显示数据
                            tsui::run_dataTable2(id = 'krmesMachineRptUI_view_data', data = data)
                            #下载数据
                            tsui::run_download_xlsx(id = 'dl_krmesMachineRptUI',data = data,filename = '机台汇报下载.xlsx')





  })
}



#' Title 后台处理总函数
#'
#' @param input 输入
#' @param output 输出
#' @param session 会话
#' @param dms_token 口令
#'
#' @return 返回值
#' @export
#'
#' @examples HrvServer()
krmesMachineRptServer <- function(input,output,session,dms_token) {
  #预览数据
  krmesMachineRptQuery(input,output,session,dms_token)

}
